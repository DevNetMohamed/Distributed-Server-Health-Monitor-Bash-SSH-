#!/usr/bin/env bash
USRE_ID=$(id -u)
#Check is user ID id NOT Zero (i.e., not root)
if [[ "$USER_ID" -ne 0 ]]; then
	echo "Error: This Script must be run as root."
	exit 1
fi
echo "Welcone, Adminstrator!"
