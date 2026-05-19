#This Script delete the User
#!/usr/bin/env bash

echo "Please Enter Username that you need to delete"

read username

newPassword=$(echo "$password" | openssl passwd -1 -stdin)

grep -w "^$username" /etc/passwd > /dev/null

if [ $? -eq 0 ] then;
	userdel -r $username
	echo "The $username is deleted Successfully"
else

	echo "$username is already dosen't exit, so there is no need for delete"
fi
