#!/bin/bash

# Get groups (in GeneratedUID form) from com.apple.access_ssh group
SSH_GROUPS=$(/usr/bin/dscl . read /Groups/com.apple.access_ssh | /usr/bin/grep NestedGroups | /usr/bin/sed 's/.*: //')

# If NestedGroups exist in com.apple.access_ssh group, process them according to whether
# they are a local group or an AD Group, as local groups will have no spaces whereas AD
# groups may.
if [ "$SSH_GROUPS" = "" ]; then
	ALL_SSH_GROUPNAMES="No SSH Groups Exist"
else
	for g in $SSH_GROUPS ; do
		RESULT=$(/usr/bin/dscl /Search -list /Groups GeneratedUID | /usr/bin/grep $g)
	
		if [[ "$RESULT" != *"YOURDOMAIN"* ]]; then
			# Process for local group name
			ALL_SSH_GROUPNAMES+=( $(/bin/echo $RESULT | tr ' ' '\n' | /usr/bin/head -1) )
		else
			# Process for AD group name
			ALL_SSH_GROUPNAMES+=( $(/bin/echo $RESULT | /usr/bin/tr ' ' '\n' | /usr/bin/sed '$ d' | /usr/bin/tr '\n' ' ' | /usr/bin/sed 's/ *$//') )
		fi
	
	done
fi

/bin/echo "<result>${ALL_SSH_GROUPNAMES[@]}</result>"