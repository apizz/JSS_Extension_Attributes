#!/bin/bash

result=$(/usr/bin/defaults read /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/version.plist CFBundleVersion)

/bin/echo "<result>$result</result>"

exit