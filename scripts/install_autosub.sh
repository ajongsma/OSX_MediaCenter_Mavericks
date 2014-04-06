#!/usr/bin/env bash
source config.sh

## https://code.google.com/p/autosub-bootstrapbill
## http://gathering.tweakers.net/forum/list_messages/1572892/22

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
  hg clone https://code.google.com/p/autosub-bootstrapbill/ /Applications/auto-sub
  sudo chown `whoami`:wheel -R /Applications/auto-sub
  #cd /Applications/auto-sub
  
  echo "-----------------------------------------------------------"
  echo "| Configuration -> Settings"
  echo "-----------------------------------------------------------"
  echo "| General Settings"
  echo "| Series Folder       : $INST_FOLDER_SERIES_COMPLETE"
  echo "| Download Dutch      : Enabled"
  echo "| Notify Dutch        : Disabled"
  echo "| Dutch Suffix        : nl"
  echo "| Fallback to English : Enabled"
  echo "| Clean up English    : Disabled"
  echo "| Download English    : Disabled"
  echo "| Notify English      : Disabled"
  echo "| English Suffix      : en"
  echo "-----------------------------------------------------------"
  osascript -e 'tell app "Terminal"
      do script "cd /Applications/auto-sub && python /Applications/auto-sub/AutoSub.py"
  end tell'
  #sudo python /Applications/auto-sub/AutoSub.py
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "-----------------------------------------------------------"
  echo "| Advanced Settings"
  echo "| Launchbrowser       : Disabled"
  echo "| - Source            : Enabled"
  echo "| - Quality           : Disabled"
  echo "| - Qodec             : Disabled"
  echo "| - Releasegroup      : Enabled"
  echo "-----------------------------------------------------------"
  echo "| Save Changes"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "-----------------------------------------------------------"
  echo "| Websites"
  echo "-----------------------------------------------------------"
  echo "| Addic7ed            : Both"
  echo "| Username            : <UserID Addic7ted>"
  echo "| Password            : <Password Addic7ted>"
  echo "-----------------------------------------------------------"
  echo "| Test Addic7ed, Save Changes"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  INST_FILE_LAUNCHAGENT="com.autosub.autosub.plist"
  if [ ! -f ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT ] ; then
    printf "$PRINTF_MASK" "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT" "$YELLOW" "[WAIT]" "$RESET"
    cp $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
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
    printf "$PRINTF_MASK" "Launch Agent $INST_FILE_LAUNCHAGENT detected" "$GREEN" "[OK]" "$RESET"
  fi

  cd $DIR
  printf "$PRINTF_MASK" "Auto-Sub installed" "$GREEN" "[OK]" "$RESET"
fi
