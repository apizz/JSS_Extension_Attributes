#!/bin/bash

mountpoint="/Volumes/.tmpmount"

# create hidden folder to mount disk
if [ ! -d "$mountpoint" ]; then
	/bin/mkdir $mountpoint
fi

# find recovery HD
RecoveryHDID=`/usr/sbin/diskutil list | /usr/bin/grep "disk0" | /usr/bin/grep "Recovery HD" | /usr/bin/awk 'END { print $NF }'`

# check if recovery HD is already mounted
volumeCheck=`/bin/ls -1 /Volumes | /usr/bin/grep "Recovery HD"`

if [ "$volumeCheck" = "" ]; then
    # mount the recovery hd
    /usr/sbin/diskutil mount readOnly -mountPoint "$mountpoint" /dev/$RecoveryHDID

    # pull the version info out
    version=`/usr/bin/defaults read $mountpoint/com.apple.recovery.boot/SystemVersion.plist ProductVersion`
else
    # pull the version info out from already mounted recovery hd
    version=`/usr/bin/defaults read $mountpoint/com.apple.recovery.boot/SystemVersion.plist ProductVersion`
fi

echo "<result>$version</result>"

# unmount hidden mountpoint
/usr/sbin/diskutil unmount $RecoveryHDID

exit