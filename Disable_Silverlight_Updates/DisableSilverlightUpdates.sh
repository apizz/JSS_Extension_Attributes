#!/bin/bash

PLUGIN="/Library/Internet Plug-Ins/Silverlight.plugin"
LOG="/Library/Logs/Silverlight-Update-Check.log"

writelog () {
	/bin/echo $(date) ${1}
	/bin/echo $(date) ${1} >> $LOG
}

if [ ! -d "$PLUGIN" ]; then
	/bin/echo "<result>Silverlight Plugin Not Installed</result>"
	exit
fi

if [ ! -f "$LOG" ]; then
	/usr/bin/touch "$LOG"
fi

SILVERLIGHT () {
	for USER in $( /bin/ls -1 /Users/ | /usr/bin/egrep -v '(.localized|arduser|Shared)' ); do
		SLVLIGHT="/Users/$USER/Library/Preferences/com.microsoft.silverlight.plist"
	
		disable_silverlight () {
			sudo -u "$USER" defaults write $SLVLIGHT UpdateMode -int 2
		
			if [ $? = 0 ];then
				writelog "Silverlight Update Check: Successfully Disabled for ${USER}!"	
			else
				writelog "Silverlight Update Check: Failed to Disable for ${USER}."
			fi
		}
	
		if [ ! -f "$SLVLIGHT" ] && [ -d "$PLUGIN" ]; then
			writelog "Silverlight PLIST does not exist for ${USER}. Creating & Disabling ..."
		
			disable_silverlight
		
		elif [ -f "$SLVLIGHT" ] && [ "$(defaults read $SLVLIGHT UpdateMode)" != "2" ]; then
			writelog "Silverlight Update Check: Enabled for ${USER}. Disabling ..."
		
			disable_silverlight
		
		elif [ -f "$SLVLIGHT" ] && [ "$(defaults read $SLVLIGHT UpdateMode)" = "2" ]; then
			writelog "Silverlight Update Check: Already Disabled for ${USER}!"
		fi
	done
}

/bin/echo "<result>$( SILVERLIGHT )</result>"

exit
