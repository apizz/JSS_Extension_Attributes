#!/bin/bash

STATUS=`/usr/sbin/firmwarepasswd -check | sed -n -e 's/^.*\:\ //p'`

if [[ "$STATUS" == "Yes" ]]; then
    result="Enabled"
else
    result="Not Enabled"
fi

echo "<result>$result</result>"

exit