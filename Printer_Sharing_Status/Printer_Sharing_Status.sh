#!/bin/bash

PRINTER_SHARING=`/usr/sbin/cupsctl | grep share_printers | sed 's/\_share\_printers\=//g'`

if [ "$PRINTER_SHARING" = "0" ]; then
    result="Disabled"
else
    result="Enabled"
fi

/bin/echo "<result>$result</result>"

exit