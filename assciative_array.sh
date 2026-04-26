#!/usr/bin/env bash
# -A means associative array

declare -A server_ips=(
# Add elements (Key inside brackets)
	[web-01]="192.168.1.10"
	[web-02]="192.168.1.11"
	[db-01]="192.168.1.20"
)

# LOOOP over the KEYS
for server in "${!server_ips[@]}"; do
	# $server is the key
	# ${server_ips[$server]} is the value
	if [[ -v server_ips["db-02"] ]]; then
		echo "DB-02 exists."
		#echo "Server: $server --- IP: ${server_ips[$server]}"
	else
		echo "DB-02 not found in our list."
	fi
done



# You can also declare an associvative array in a single line
#declare -A users=([admin]="ahmed" [guest]="user1" [test]="user2")
#echo "Web-01 Ip is: ${server_ips[web-01]}"
#echo "Admin user is: ${users[admin]}"

