#!/bin/bash

###########
#
# Proactive EA that checks AD pass interval. If not set to 0, attempts to.  Not being set
# to 0 can cause problems for users where password change policies are already in place.
#
###########

adpass=`/usr/sbin/dsconfigad -show | grep "Password" | sed -n -e 's/^.*\=\ //p'`

if [ "$adpass" != "0" ]; then
	echo "AD password Interval not set to 0. Setting ..."
	
	sudo /usr/sbin/dsconfigad -passinterval 0
	
	if [ "$(/usr/sbin/dsconfigad -show | grep "Password" | sed -n -e 's/^.*\=\ //p')" = "0" ]; then
		echo "AD Password Interval: Successfully set to 0"
		result="OK"
	else
		result="AD Password Interval: Failed to set AD Password Interval to 0"
	fi
else
	result="OK"
fi

echo "<result>$result</result>"

exit