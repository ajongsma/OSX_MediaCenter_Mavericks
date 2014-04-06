#!/usr/bin/env bash
source config.sh

if [ ! -e /usr/local/bin/brew ] ; then
  printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
  read -n 1 -s
  exit 1
fi

if [ -d /Applications/auto-sub ] ; then
  printf "$PRINTF_MASK" "Auto-Sub detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "Auto-Sub not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  
  if [ -e /usr/local/bin/hg ] ; then
    printf "$PRINTF_MASK" "HG detected" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "HG not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    brew install hg
  fi
  
  cd /Applications
  hg clone https://code.google.com/p/auto-sub/
  sudo chown `whoami`:wheel -R /Applications/auto-sub
  cd /Applications/auto-sub
  
  echo "-----------------------------------------------------------"
  echo "| Click main menu item Config (niet sub-menu item(s)), General:"
  echo "| Rootpath            : /Users/Andries/Media/Series"
  echo "| Launchbrowser       : Disabled"
  echo "| Fallback to English : Enabled"
  #echo "| Subtitle English    : nl"
  echo "| Subtitle English    : en"
  echo "| Subtitle Dutch      : nl"
  echo "| Notify English      : Disabled"
  echo "| Notify Dutch        : Disabled"
  echo "-----------------------"
  echo "| Save"
  echo "-----------------------------------------------------------"
  osascript -e 'tell app "Terminal"
      do script "python /Applications/auto-sub/AutoSub.py"
  end tell'
  #sudo python /Applications/auto-sub/AutoSub.py
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  
  INST_FILE_LAUNCHAGENT="com.autosub.autosub.plist"
  if [ -f ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT ] ; then
    printf "$PRINTF_MASK" "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT" "$YELLOW" "[WAIT]" "$RESET"
    cp $DIR/launchctl/config/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
    if [ "$?" != "0" ]; then
      echo -e "${RED}  ============================================== ${RESET}"
      echo -e "${RED} | ERROR ${RESET}"
      echo -e "${RED} | Copy failed: ${RESET}"
      echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
      echo -e "${RED} | --- press any key to continue --- ${RESET}"
      echo -e "${RED}  ============================================== ${RESET}"
      read -n 1 -s
      exit 1
    fi
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
  else
    printf "$PRINTF_MASK" "Launch Agent detected" "$GREEN" "[OK]" "$RESET"
  fi

  cd $DIR
  printf "$PRINTF_MASK" "Auto-Sub installed" "$GREEN" "[OK]" "$RESET"
fi

##### TESTING #####
exit 0
##### TESTING #####

#AutoSub.py  ExamplePostProcess.py  README.txt  autosub changelog.xml  cherrypy  init.ubuntu  interface  library

#echo "Download latest Auto-Sub from http://code.google.com/p/auto-sub/"
#open http://code.google.com/p/auto-sub/downloads/list
#
#while ( [ ! -e ~/Downloads/auto-sub ] )
#do
#    printf 'Waiting for Auto-Sub to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
#    sleep 15
#done
#sleep 3
#sudo mv ~/Downloads/auto-sub /Applications/
