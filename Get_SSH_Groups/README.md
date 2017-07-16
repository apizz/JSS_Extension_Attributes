Script reads the NestedGroups attribute for the com.apple.access_ssh group to determine any group(s) that have SSH access.

Unlike the Get_SSH_Users.sh script where the names of individual users are listed, all groups listed under the NestedGroups attribute are displayed as their respective GeneratedUID number.  The script uses this number to grep the full list of groups to determine what the name of the group is. 

I work in an AD environment and there are a number of groups that have spaces in the name.  To more efficiently process these, the script determines whether or not the group in question is a local Mac group or an AD group in order to correctly parse the group names.
