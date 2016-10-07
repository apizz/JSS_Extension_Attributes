#!/bin/bash

PLIST="/Library/Preferences/com.oracle.java.Java-Updater.plist"
LOG="/Library/Logs/Java-Update-Check.log"

writelog () {
    /bin/echo $(date) ${1}
    /bin/echo $(date) ${1} >> $LOG
}

if [ ! -f "$PLIST" ]; then
	result="Java Not Installed"
	
elif [ -f "$PLIST" ] && [ ! "$(/usr/bin/defaults read $PLIST JavaAutoUpdateEnabled)" = "0" ]; then 
	writelog "Java Auto Update Checks Enabled. Disabling ..."
	
	/usr/bin/defaults write "$PLIST" JavaAutoUpdateEnabled -bool false
	
	if [ "$(/usr/bin/defaults read $PLIST JavaAutoUpdateEnabled)" = "0" ]; then
		writelog "Java Updates Disabled"
		result="Updates Disabled"
		
	else
		writelog "Java Updates Not Disabled"
		result="Updates Not Disabled"
		
	fi
else
	writelog "Jave Updates Already Disabled"
	result="Updates Already Disabled"
fi

/bin/echo "<result>$result</result>"

exit
