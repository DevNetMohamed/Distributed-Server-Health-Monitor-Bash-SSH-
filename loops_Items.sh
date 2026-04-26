#!/usr/bin/env bash

FRUITS=("apple" "banana" "Orange");

for fruit in "${FRUITS[@]}";
do
	echo "I like $fruit"
done

for(( i=1; i<5; i++)); do
	echo "Creating user User$i"
	#sudo useradd "user$i"
done

for pod_name in $(kubectl get pods -n my-app | grap 'Error' | awk '{print $1}'); 
do
	echo "Restarting pod: $pod_name"
	kubectl delete pod "$pod_name" -n my-app
done
