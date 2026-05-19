#!/usr/bin/env bash
# Create a new user

echo "Please Enter Username"

read username

newPassword=$(echo "$password" | openssl passwd -1 -stdin)

grep -w "^$username" /etc/passwd > /dev/null

if [ $? -eq 0 ] then;
	echo "User $username is Already Existed"
else
	echo "Please Enter Password"
	read -s password

	useradd -md /home/$username $username -p $newPassword
	echo "Congrats $username is created and password as well"
fi


