#!/usr/bin/env bash
# $1 is the first argument passed to the script
# Example: ./service.sh start
# ===================================================
ACTION="$1"
# Check if the user provided an action

if [[ -z "$ACTION" ]]; then
	echo "Error: No action Provided"
	echo "Usage: $0 [start|stop|restart]"
	exit1
fi


case "$ACTION" in
	start)
		echo "Starting the service..."
		# Place your systemctl start command here
	;;
	stop)
		echo "Stopping the service..."
		# Place your systemctl stop command here
	;;
	restart)
		echo "Restart the service..."
		# Place your systemctl restart command here
	;;
	
	*)
		echo "Error: Unkown action '$ACTION'"
		echo "Usage:$0 [start|stop|restart]"
		exit 
	;;
esac
echo "Done."
