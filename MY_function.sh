#!/usr/bin/env bash

# 1. Define the function
get_formatted_date() {
    local name="$1"
    local date
    date=$(date +"%Y-%m-%d")

    echo "$name (Date: $date)"
}

# 2. Call the Function and capture the output
user_string=$(get_formatted_date "Mohamed")
report_string=$(get_formatted_date "Report_Backup")

echo "Result 1: $user_string"
echo "Result 2: $report_string"
