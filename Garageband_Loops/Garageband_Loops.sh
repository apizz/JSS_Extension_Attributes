#!/bin/bash

#
# To be used in conjunction with my modified Jacob Salmela's download & install GB Loops bash script.
#
# This EA references a log file to determine if any GB loop packages failed to download or install.
#
# Original script:
# https://github.com/jacobsalmela/adminscripts/blob/master/downloadGarageBandContentPkgs.sh
#
# My modified loop download & install script w/ logging:
# https://github.com/apizz/adminscripts/blob/master/downloadGarageBandContentPkgs.sh
#
#

gbLog="/path/to/GaragebandLoopInstalls.log"

# Checks if log exists
if [ -f "$gbLog" ]; then
    # If log exists, reads the log to find any failures
    cat "$gbLog" | grep "Failed"
    # Saves exit code
    logcheck=`echo $?`
    if [ "$logcheck" = 1 ]; then
        # If no failures detected, gives success status
        result="Successfully Installed"
    elif  [ "$logcheck" = 0 ]; then
        # If failures detected gives error status
        result="Install Errors Detected"
    else
        # If an unknown error occurs, gives error status
        result="Something went wrong ..."
    fi
else
    # If no log exists, gives not installed status
    result="Not Installed"
fi

echo "<result>$result</result>"

exit
