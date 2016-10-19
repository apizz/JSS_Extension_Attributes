#!/bin/bash

TEAMVIEWER="/Applications/TeamViewer.app"
TEAMVIEWER_HOST="/Applications/TeamViewerHost.app"
PLIST="/Library/Preferences/com.teamviewer.teamviewer.preferences.plist"

if [ -d "$TEAMVIEWER_HOST" ] || [ -d "$TEAMVIEWER" ]; then
    result=`/usr/bin/defaults read "$PLIST" ClientID`
else
    result="TeamViewer Host Not Installed"
fi

/bin/echo "<result>$result</result>"

exit
