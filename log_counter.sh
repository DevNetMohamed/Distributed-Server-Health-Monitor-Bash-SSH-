#!/usr/bin/env bash

# 1. Define the associative array
declare -A error_counts
LOG_FILE="/var/log/app.log"

# 2. Make sure the log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: log file not found: $LOG_FILE"
    exit 1
fi

# 3. Read the file line by line
while IFS= read -r line; do

    # Extract part before colon
    log_type=$(echo "$line" | awk -F':' '{print $1}')

    # Skip empty
    [[ -z "$log_type" ]] && continue

    # 4. Increment counter
    ((error_counts["$log_type"]++))

done < "$LOG_FILE"

# 5. Print report
echo "--- Log Analysis Report ---"

for type in "${!error_counts[@]}"; do
    echo "$type: ${error_counts[$type]}"
done
