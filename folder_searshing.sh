#!/usr/bin/env bash
LOG_DIR="/var/log/my-app"
FOUND_FILE=""

# LOOP through all files ending with .log
#
for log_file in "$LOG_DIR"/*.log;
do
	echo "Scanning file: $log_file"
# -q (quiet) makes qrep silent; we only care about thid exit code 

if grep -q "FATAL_ERROR" "$log_file"; then
	echo "Found error in: $log_file"
	FOUND_FILE="$log_file"

# Stop scanning once we find the first corrupted file
	break
fi
done

# The Script continuse here after the break
if [ -n "$FOUND_FILE" ]; then
	echo "The first corrupted file is : $FOUND_FILE"
	# You can send an email or alert here
else
	echo "No corrupted file found."
fi
