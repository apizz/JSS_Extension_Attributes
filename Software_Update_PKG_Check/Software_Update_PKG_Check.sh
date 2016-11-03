#!/bin/bash

# Function to search for PKG files in the /Library/Updates directly
function ASU_PKGS () {
    for PKG in $( find /Library/Updates -iname "*.pkg" ); do
	    FILE=$( basename $PKG )
	
	    /bin/echo $PKG
	done
}

if [ "$(ASU_PKGS)" = "" ]; then
    /bin/echo "<result>No PKGs Found</result>"
else
	# If PKGs are found, prints the full path of each PKG
    /bin/echo "<result>$( ASU_PKGS )</result>"
fi

exit