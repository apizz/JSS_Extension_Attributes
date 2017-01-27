#!/bin/bash

########################
# Created by AP Orlebeke - 1/27/17
#
# For use with my JSS_Imaging_Config_Log bash script for writing the imaging configuration used to image
# a machine.  This can bash script can be found here:
# https://github.com/apizz/Mac_Scripts/blob/master/JSS_Imaging_Configuration_Log/JSS_Imaging_Config_Log.sh
########################

LOG="/var/log/imagingconfig.log"
RESULT=$(/usr/bin/tail -1 "$LOG")

/bin/echo "<result>$RESULT</result>"

exit
