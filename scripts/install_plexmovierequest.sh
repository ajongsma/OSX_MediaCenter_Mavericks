#!/usr/bin/env bash
source config.sh

## https://forums.plex.tv/index.php/topic/151899-plex-movie-requests
## https://github.com/lokenx/plexrequests-meteor/
## https://www.pushbullet.com

function check_config_defaults() {
  if [[ -z $INST_PLEXREQUEST_PATH ]] || [[ -z $INST_PLEXREQUEST_UID ]] || [[ -z $INST_PLEXREQUEST_PW ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| PlexRequest Path            : INST_PLEXREQUEST_PATH"
    echo "| PlexRequest UserID          : INST_PLEXREQUEST_UID"
    echo "| PlexRequest Password        : INST_PLEXREQUEST_PW"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_PLEXREQUEST_PATH == "" ]] || [[ $INST_PLEXREQUEST_UID == "" ]] || [[ $INST_PLEXREQUEST_PW == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf '.\n'
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

if [[ -z $INST_PLEXREQUEST_PATH ]]; then
  printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
  echo "| PlexRequest Path            : INST_PLEXREQUEST_PATH"
  if [ ! -d /Applications/TextWrangler.app ]; then
    pico config.sh
  else
    open -a /Applications/TextWrangler.app config.sh
  fi
  while ( [[ $INST_PLEXREQUEST_PATH == "" ]] )
  do
    printf '.'
    sleep 2
    source config.sh
  done
  printf '.\n'
  printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
fi

if [ -h $INST_PLEXREQUEST_PATH/plexrequests-meteor ] ; then
  printf "$PRINTF_MASK" "-> Plex Movie Request detected" "$GREEN" "[OK]" "$RESET"
  echo "-> $INST_PLEXREQUEST_PATH/plexrequests-meteor"
  check_config_defaults
  #check_config_var
else
  printf "$PRINTF_MASK" "-> Plex Movie Request not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults

  if [ ! -d $INST_PLEXREQUEST_PATH ] ; then
    printf "$PRINTF_MASK" $INST_PLEXREQUEST_PATH" does't exists, creating" "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_PLEXREQUEST_PATH
    sudo chown `whoami` $INST_PLEXREQUEST_PATH
  else
    printf "$PRINTF_MASK" $INST_PLEXREQUEST_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -d $INST_PLEXREQUEST_PATH/plexrequests-meteor ] ; then
    printf "$PRINTF_MASK" " Plex Movie Request does't exists, downloading" "$YELLOW" "[WAIT]" "$RESET"
    cd $INST_PLEXREQUEST_PATH
    
    echo "------------------------------------------"
    echo " Installing Meteor"
    echo "------------------------------------------"
    curl https://install.meteor.com/ | sh
    
    echo "------------------------------------------"
    echo " Downloading PlexRequest-Meteor"
    echo "------------------------------------------"
    git pull https://github.com/lokenx/plexrequests-meteor.git
    
    echo "------------------------------------------"
    echo " Starting PlexRequest-Meteor"
    echo "------------------------------------------"
    cd $INST_PLEXREQUEST_PATH/plexrequests-meteor
    sh meteor
    
    echo "------------------------------------------"
    echo " Opening admin page"
    echo "------------------------------------------"
    open http://pooky.local:3000/admin
    
    echo "------------------------------------------"
    echo " Opening admin plex connection page"
    echo "------------------------------------------"
    http://pooky.local:3000/plex
    
    echo "------------------------------------------"
    echo " Opening admin couchpotato connection page"
    echo "------------------------------------------"
    http://pooky.local:3000/couchpotato
  fi

  INST_FILE_LAUNCHAGENT="com.plexrequest.plexrequest.plist"
    if [ ! -f ~/Library/LaunchAgents/ ] ; then
      printf 'LaunchAgent not found, installing...\n' "$YELLOW" $col '[WAIT]' "$RESET"
    
      if [ -f $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
        printf 'Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT' "$YELLOW" $col '[WAIT]' "$RESET"
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
      else
        echo -e "${RED}  ============================================== ${RESET}"
        echo -e "${RED} | ERROR ${RESET}"
        echo -e "${RED} | LaunchAgent file not found: ${RESET}"
        echo -e "${RED} | $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
        echo -e "${RED} | --- press any key to continue --- ${RESET}"
        echo -e "${RED}  ============================================== ${RESET}"
        read -n 1 -s
      fi
      launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
    else
      printf 'LaunchAgent found' "$GREEN" $col '[OK]' "$RESET"
    fi


fi
