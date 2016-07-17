#!/bin/sh

WORD="/Applications/Microsoft Word.app"
EXCEL="/Applications/Microsoft Excel.app"
PPT="/Applications/Microsoft PowerPoint.app"
ONENOTE="/Applications/Microsoft OneNote.app"
OUTLOOK="/Applications/Microsoft Outlook.app"
MAU="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app"

if [ -d "$WORD" ] ; then
    WVERSION="Word: $( /usr/bin/defaults read "$WORD"/Contents/Info CFBundleShortVersionString )"
else
    WVERSION="Word: Not Installed"
fi

if [ -d "$EXCEL" ]; then
	EVERSION="Excel: $( /usr/bin/defaults read "$EXCEL"/Contents/Info CFBundleShortVersionString )"
else
	EVERSION="Excel: Not Installed"
fi

if [ -d "$PPT" ]; then
	PVERSION="PPT: $( /usr/bin/defaults read "$PPT"/Contents/Info CFBundleShortVersionString )"
else
	PVERSION="PPT: Not Installed"
fi

if [ -d "$ONENOTE" ]; then
	ONVERSION="OneNote: $( /usr/bin/defaults read "$ONENOTE"/Contents/Info CFBundleShortVersionString )"
else
	ONVERSION="OneNote: Not Installed"
fi

if [ -d "$OUTLOOK" ]; then
	OUVERSION="Outlook: $( /usr/bin/defaults read "$OUTLOOK"/Contents/Info CFBundleShortVersionString )"
else
	OUVERSION="Outlook: Not Installed"
fi

if [ -d "$MAU" ]; then
	MAUVERSION="MAU: $( /usr/bin/defaults read "$MAU"/Contents/Info CFBundleShortVersionString )"
else
	MAUVERSION="MAU: Not Installed"
fi

echo "<result>$WVERSION
$EVERSION
$PVERSION
$ONVERSION
$OUVERSION
$MAUVERSION</result>"

exit