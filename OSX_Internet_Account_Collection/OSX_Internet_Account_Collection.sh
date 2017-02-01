#!/bin/bash

RESULT=()

for USER in /Users/* ; do
    if [ -f "$USER/Library/Accounts/Accounts3.sqlite" ]; then
    	INTERNET_ACCOUNTS=$(sqlite3 "$USER/Library/Accounts/Accounts3.sqlite" 'SELECT ZUSERNAME, ZACCOUNTDESCRIPTION FROM ZACCOUNT' | tr '|' ' ' | awk NF | tr ' ' '|')
    	if [ "$INTERNET_ACCOUNTS" != "" ]; then
    		RESULT+=(===$(basename $USER)===)
    		RESULT+=("$INTERNET_ACCOUNTS")
    	fi
    fi
done

if [ "$RESULT" = "" ]; then
	/bin/echo "<result>No Internet Accounts Detected</result>"
else
	/bin/echo "<result>$(printf '%s\n' ${RESULT[@]})</result>"
fi

exit