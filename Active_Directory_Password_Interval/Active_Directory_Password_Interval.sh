#!/bin/bash

adpass=`/usr/sbin/dsconfigad -show | grep "Password" | sed -n -e 's/^.*\=\ //p'`

if [ "$adpass" != "0" ]; then
	echo "AD password Interval not set to 0. Setting ..."
	
	sudo /usr/sbin/dsconfigad -passinterval 0
	
	if [ "$(/usr/sbin/dsconfigad -show | grep "Password" | sed -n -e 's/^.*\=\ //p')" = "0" ]; then
		echo "AD Password Interval: Successfully set to 0"
		result="OK"
	else
		result="Failed to set AD Password Interval to 0"
	fi
else
	result="OK"
fi

echo "<result>$result</result>"

exit