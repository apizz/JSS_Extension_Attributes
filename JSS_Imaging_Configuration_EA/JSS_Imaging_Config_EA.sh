#!/bin/bash

LOG="/var/log/imagingconfig.log"
RESULT=$(/usr/bin/tail -1 "$LOG")

/bin/echo "<result>$RESULT</result>"

exit