#!/usr/bin/env bash
# 1. Get today's date using the'date' command and store it in a variable
# we use +%Y-%m-%d to format the date.
today=$(date +"%Y-%m-%d")

# 2. Create a dynamic directory name
backup_dir="/home/mohamed-adel/ShellScript/backup-$today"
source_file="/var/log/syslog"
#check if backup directory existed
if [[ ! -d "$backup_dir" ]]; then
	echo "Directory $backup_dir NOT Found. Creating..."
	mkdir "$backup_dir"

# 3. Print what we are about to do (Using our variables!)
	echo "Creating backup directory: $backup_dir"
	echo "Checking for directory: $bachup_dir"
else
	echo "Directory $backup_dir already exists"
fi



if [[ ! -f "$source_file" || ! -r "$source_file" ]]; then
	# This block runs IF the condation is TRUE
	echo "Error: Source file $source_file dose not exist or is not readable."
	exit 1
fi
# Check if source file is empty
if [[ ! -s "$source_file " ]]; then
	echo "Warning: Source file $source_file is empty. Backing up anyway."
fi

cp "$source_file" "$backup_dir/syslog.bak"
echo "Backup of $source_file completed successfuly to $backup_dir"
