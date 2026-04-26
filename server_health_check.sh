#!/usr/bin/env bash
# server_health_check.sh
#
# A DevOps capstone Project script to check the health
# of multiple remote servers via SSH
#
# Usage: ./server_health_check.sh -f <server_list_file> -u <remote_user>

# --- part 1: "Strict Mode" ---
# set -e: exit immediately if any command fails
# set -u: exit if an undefined variable is used
# set -o pipefail: fail if any command in pipeline fails
set -euo pipefail

# --- Global Constants ---

# Create a temporary log file
LOG_FILE=$(mktemp /tmp/server_health.XXXXXX)
readonly LOG_FILE

# JSON report file
REPORT_FILE="report.json"

# Slack webhook 
SLACK_WEBHOOK="" #add Link slack here

# --- Function Definitions ---

# Log info message
log_info(){
    echo "[INFO] $1" | tee -a "$LOG_FILE"
}

# Log error message
log_error(){
    echo "[ERROR] $1" | tee -a "$LOG_FILE" >&2
}

# Print usage
print_usage(){
    echo "Usage: $0 -f <server_list_file> -u <remote_user>"
}

# Cleanup function
cleanup(){
   echo "Cleaning up temporary log file: $LOG_FILE"
   rm -f "$LOG_FILE"
}

# Send message to Slack
send_slack(){
    local message="$1"

    [[ -z "$SLACK_WEBHOOK" ]] && return

    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$message\"}" \
    "$SLACK_WEBHOOK" > /dev/null
}

# Perform health check on a server
check_server(){
    local server="$1"
    local user="$2"

    log_info "Checking server: $server"

    # SSH command block
    result=$(ssh -o ConnectTimeout=5 "${user}@${server}" << 'EOF'
echo "UPTIME:"
uptime

echo "DISK:"
USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
echo "$USAGE"

echo "MEMORY:"
free -m | awk 'NR==2 {printf "%.2f\n", ($3/$2)*100}'

echo "SSH_FAILS:"
if [[ -f /var/log/auth.log ]]; then
    grep -c "Failed password" /var/log/auth.log
else
    echo "0"
fi
EOF
)

    # Extract values
    disk_usage=$(echo "$result" | grep -A1 "DISK:" | tail -n1)
    mem_usage=$(echo "$result" | grep -A1 "MEMORY:" | tail -n1)
    ssh_fails=$(echo "$result" | grep -A1 "SSH_FAILS:" | tail -n1)

    # Alert if disk > 80%
    if [[ "$disk_usage" -gt 80 ]]; then
        log_error " $server disk usage is high: $disk_usage%"
        send_slack " $server disk usage is high: $disk_usage%"
    fi

    # Append to JSON report
    echo "{
  \"server\": \"$server\",
  \"disk\": \"$disk_usage\",
  \"memory\": \"$mem_usage\",
  \"ssh_failed\": \"$ssh_fails\"
}," >> "$REPORT_FILE"

    log_info "Finished: $server"
}

# Main function
main(){
    local server_file=""
    local remote_user=""

    # --- Argument Parsing ---
    while getopts ":f:u:h" opt; do
        case "$opt" in
            f) server_file="$OPTARG" ;;
            u) remote_user="$OPTARG" ;;
            h) print_usage; exit 0 ;;
            \?) log_error "Invalid option"; exit 1 ;;
            :) log_error "Missing argument"; exit 1 ;;
        esac
    done

    # Validation
    if [[ -z "$server_file" || -z "$remote_user" ]]; then
        log_error "Missing arguments"
        print_usage
        exit 1
    fi

    if [[ ! -f "$server_file" ]]; then
        log_error "Server file not found"
        exit 1
    fi

    # Read servers into array
    servers=()
    while IFS= read -r line; do
        [[ -z "$line" || "$line" == \#* ]] && continue
        servers+=("$line")
    done < "$server_file"

    if [[ ${#servers[@]} -eq 0 ]]; then
        log_error "No servers found"
        exit 1
    fi

    log_info "Found ${#servers[@]} servers. Starting checks..."

    # Initialize JSON
    echo "[" > "$REPORT_FILE"

    # --- Parallel Execution ---
    PIDS=()

    for server in "${servers[@]}"; do
        check_server "$server" "$remote_user" &
        PIDS+=($!)
    done

    # Wait for all processes
    for pid in "${PIDS[@]}"; do
        wait "$pid"
    done

    # Fix JSON (remove last comma)
    sed -i '$ s/,$//' "$REPORT_FILE"
    echo "]" >> "$REPORT_FILE"

    log_info "All checks completed"

    send_slack " Server health check completed"
}

# --- TRAP ---
trap cleanup EXIT INT TERM

echo "Script started. Log file: $LOG_FILE"

# --- Execution ---
main "$@"