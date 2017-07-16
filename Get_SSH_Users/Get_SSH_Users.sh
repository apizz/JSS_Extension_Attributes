#!/bin/bash

# Get users from com.apple.access_ssh group
SSH_USERS=$(/usr/bin/dscl . read /Groups/com.apple.access_ssh | /usr/bin/grep GroupMembership | /usr/bin/sed 's/.*: //')

# If users exist in com.apple.access_ssh group, print them
if [ "$SSH_USERS" = "" ]; then
	ALL_SSH_USERNAMES="No SSH Users Exist"
else
	ALL_SSH_USERNAMES="$SSH_USERS"
fi

/bin/echo "<result>${ALL_SSH_USERNAMES}</result>"