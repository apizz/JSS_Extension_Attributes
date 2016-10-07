#!/bin/bash

FLASH_PLUGIN="/Library/Internet Plug-Ins/Flash Player.plugin"
FLASH_DIR="/Library/Application Support/Macromedia"
FLASH_CFG="/Library/Application Support/Macromedia/mms.cfg"
AUTO_UPDATE=`/bin/cat "$FLASH_CFG" | /usr/bin/head -n 1`
SILENT_UPDATE=`/bin/cat "$FLASH_CFG" | /usr/bin/tail -n 1`
LOG="/Library/Logs/Java-Updates-Check.log"

writelog () {
	/bin/echo $(date) ${1}
	/bin/echo $(date) ${1} >> $LOG
}

make_flash () {
    writelog "Flash mms.cfg does not exist. Creating ..."
    /bin/mkdir -p "$FLASH_DIR"
}

disable_flash () {
    writelog "Disabling Flash Updates ..."
	/bin/echo "AutoUpdateDisable=1" > "$FLASH_CFG"
	/bin/echo "SilentAutoUpdateEnable=0" >> "$FLASH_CFG"
	
	/usr/sbin/chown root:admin "$FLASH_CFG"
	/bin/chmod 644 "$FLASH_CFG"
}

# If Flash plugin doesn't exist, says not installed
if [ ! -d "$FLASH_PLUGIN" ]; then
    result="Flash Not Installed"

# Checks mms.cfg file lines and if one of the two lines is set to check for updates, rewrites the file to disable
elif [ ! -d "$FLASH_DIR" ]; then
		
    make_flash
    
    if [ -d "$FLASH_DIR" ]; then
        
        disable_flash
        
        if [ $? = 0 ]; then
            result="Updates Disabled"
        else
            result="Update Disable Error"
        fi
    fi

elif [ "$AUTO_UPDATE" != "AutoUpdateDisable=1" ] || [ "$SILENT_UPDATE" != "SilentAutoUpdateEnable=0" ]; then
	
	disable_flash
	
	if [ $? = 0 ]; then
        writelog "Updates Disabled"
        result="Updates Disabled"
    else
        writelog "Updates Disable Error"
        result="Update Disable Error"
    fi

elif [ "$AUTO_UPDATE" = "AutoUpdateDisable=1" ] && [ "$SILENT_UPDATE" = "SilentAutoUpdateEnable=0" ]; then
	writelog "Updates Already Disabled"
	result="Updates Already Disabled"
else
    writelog "Unknown Error"
    result="Unknown Error"
fi

/bin/echo "<result>$result</result>"

exit
