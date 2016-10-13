#!/bin/bash

###########
#
# Proactive EA that checks AD pass interval. If not set to 0, attempts to.  Not being set
# to 0 can cause problems for users where password change policies are already in place.
#
###########

adpass=`/usr/sbin/dsconfigad -show | grep "Password" | sed -n -e 's/^.*\=\ //p'`

if [ "$adpass" != "0" ]; then
	/bin/echo "AD password Interval not set to 0. Setting ..."
	
	sudo /usr/sbin/dsconfigad -passinterval 0
	
	if [ "$(/usr/sbin/dsconfigad -show | grep "Password" | sed -n -e 's/^.*\=\ //p')" = "0" ]; then
		/bin/echo "AD Password Interval: Successfully set to 0"
		result="OK"
	else
		/bin/echo "AD Password Interval: Failed to set to 0"
		result="AD Password Interval: Failed to set AD Password Interval to 0"
	fi
else
	result="OK"
fi

/bin/echo "<result>$result</result>"

exit
