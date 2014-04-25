#!/usr/bin/env bash
source config.sh

## http://www.qlambda.com/2013/07/running-vnstat-in-os-x.html
## https://forums.plex.tv/index.php/topic/93731-upsboard-usenet-plex-stats/

if [ -f /usr/local/bin/vnstat ] ; then
  printf "$PRINTF_MASK" "VnStat detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "VnStat not detected, installing..." "$GREEN" "[OK]" "$RESET"

  if [ ! -e /usr/local/bin/brew ] ; then
    printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
    echo " --- press any key to continue ---"
    read -n 1 -s
    exit 1
  else
    brew install vnstat
    
    /usr/local/Cellar/vnstat/1.11/etc/vnstat.conf
    
    #Interface "eth0"
    echo "# default interface"
    cat /usr/local/Cellar/vnstat/1.11/etc/vnstat.conf | grep Interface
    #DatabaseDir "/usr/local/var/db/vnstat"
    echo "# location of the database directory"
    cat /usr/local/Cellar/vnstat/1.11/etc/vnstat.conf | grep DatabaseDir
    
    vnstat -u -i en0
  fi

  INST_FILE_LAUNCHAGENT="local.vnstat.vnstat.plist"
  if [ -f $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
    printf "$PRINTF_MASK" "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT" "$YELLOW" "[WAIT]" "$RESET"
    cp $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
    if [ "$?" != "0" ]; then
      echo -e "${RED}  ============================================== ${RESET}"
      echo -e "${RED} | ERROR ${RESET}"
      echo -e "${RED} | Copy failed: ${RESET}"
      echo -e "${RED} | $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
      echo -e "${RED} | --- press any key to continue --- ${RESET}"
      echo -e "${RED}  ============================================== ${RESET}"
      read -n 1 -s
      exit 1
    fi
    sudo chown root:wheel ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
    #sudo launchctl unload /Library/LaunchDaemons/local.vnstat.plist
  else
    printf "$PRINTF_MASK" "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT" "$GREEN" "[OK]" "$RESET"
  fi

  #sudo launchctl list | grep vnstat
  if [ -f /usr/local/bin/vnstat ] ; then
    printf "$PRINTF_MASK" "VnStat detected" "$GREEN" "[OK]" "$RESET"
    vnstat #lists complete usage
    vnstat -d #lists daily usage
  else
    printf "$PRINTF_MASK" "VnStat not detected, installing..." "$GREEN" "[OK]" "$RESET"
  fi
fi
