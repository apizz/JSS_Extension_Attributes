#!/bin/bash

########################
# Created by AP Orlebeke - 1/27/17
#
# For use with my JSS_Imaging_Config_Log bash script for writing the imaging configuration used to image
# a machine.  This bash script can be found here:
# https://github.com/apizz/Mac_Scripts/blob/master/JSS_Imaging_Configuration_Log/JSS_Imaging_Config_Log.sh
########################

LOG="/var/log/jamf.log"
RESULT=$(/bin/cat "$LOG" | /usr/bin/grep IMAGINGCONFIG | /usr/bin/tail -1 | /usr/bin/sed -n -e 's/^.*IMAGINGCONFIG //p')

if [ "$RESULT" = "" ]; then
  RESULT="No Imaging Config Log Exists"
fi

/bin/echo "<result>$RESULT</result>"

exit
