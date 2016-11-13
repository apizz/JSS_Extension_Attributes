#!/bin/bash

# Prevents login access for default accounts EXCEPT the local admin user from logging in
# by setting the UserShell for each user account to /usr/bin/false

USER=('root'
'ladmin'
'casperadmin')
RESULT=()

for ((i = 0; i < "${#USER[@]}"; i++)); do	
	# Gets UserShell given USER array entry
	SHELL=`/usr/bin/dscacheutil -q user -a name ${USER[$i]} | /usr/bin/grep shell | /usr/bin/awk '{print $2}'`
	
	if [ "${USER[$i]}" != "ladmin" ]; then
		# For all users not the local admin, checks if the shell is NOT /usr/bin/false,
		# which if true changes the UserShell for the user
		if [ "$SHELL" != "/usr/bin/false" ]; then
			/bin/echo "${USER[$i]} UserShell is ${SHELL}. Changing UserShell ..."
			
			# Sets UserShell to /usr/bin/false
			/usr/bin/chsh -s /usr/bin/false "${USER[$i]}"
			
			if [ $? = 0 ]; then
				NEWSHELL=`/usr/bin/dscacheutil -q user -a name ${USER[$i]} | /usr/bin/grep shell | /usr/bin/awk '{print $2}'
				
				/bin/echo "Successfully changed UserShell for ${USER[$i]} from ${SHELL} to {$NEWSHELL}!"
				
				RESULT+=("${USER[$i]}:${NEWSHELL}")
			else
				/bin/echo "Failed to change UserShell for ${USER[$i]} from ${SHELL} to /usr/bin/false."
				
				RESULT+=("${USER[$i]}:${SHELL}")
			fi
		else
			/bin/echo "${USER[$i]} UserShell is ${SHELL}. Login is already disabled!"
			RESULT+=("${USER[$i]}:${SHELL}")
		fi
	else
		RESULT+=("${USER[$i]}:${SHELL}")
	fi
done

/bin/echo "<result>$(printf "%s\n" ${RESULT[@]})</result>"

exit
