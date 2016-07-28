#!/bin/bash

result=`du -mc /private/var/vm/swap* | tail -n 1 | awk '{print $1}'`

echo "<result>$result</result>"

exit