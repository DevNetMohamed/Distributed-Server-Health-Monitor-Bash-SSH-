#!/usr/bin/env bash
#Loop A (Outer Loop)
#
for i in 1 2 3; do
	echo "--- Outer looop (i=$i) ---"

#Loop B (Inner Loop)

	for j in 'a' 'b' 'c'; do
		echo " --- Inner Loop (j=$j)"
	
		# Break 2 exits both the inner and the outer loops
	
		if [[ "$j" == "b" ]]; then
			echo " Found 'b', breaking ALL loops (break 2)..."
			break 2
		fi
	done

	echo "--- End of Outer loop (i=$i) ---"
done



