#!/bin/bash

#########
#
# For use in conjunction with forked Jacob Salmela's GB Loop download script
# original: https://github.com/jacobsalmela/adminscripts/blob/master/downloadGarageBandContentPkgs.sh
#
# for use with this script: https://github.com/apizz/adminscripts/blob/master/downloadGarageBandContentPkgs.sh
#
# Added function to original GB Loop download script to write to a log file. EA uses
# this log file to determine if there were any download or install failures.
#
##########

gbLog="/path/to/gbLog.log"

# Checks if log exists
if [ -f "gbLog" ]; then

	# Reads log file for "Failed"
	cat "$gbLog" | grep "Failed"
	
	# Saves the exit code
	logcheck=`echo $?`
	
	# Determines EA result
	if [ "$logcheck" = "1" ]; then
		result="Successfully Installed"
	elif [ "$logcheck" = "0" ]; then
		result="Install Errors Detected"
	else
		result="Unknown Error"
	fi
else
	# If no log exists, gives not installed result status
	result="Not Installed"
fi

echo "<result>$result</result>"

exit