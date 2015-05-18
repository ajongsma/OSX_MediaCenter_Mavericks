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
    meteor
    
    echo "------------------------------------------"
    echo " Opening admin page"
    echo "------------------------------------------"
    open http://localhost:3000/admin
    
  fi



fi
