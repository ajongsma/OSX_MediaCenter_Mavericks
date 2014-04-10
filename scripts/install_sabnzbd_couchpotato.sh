#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_NZBTOMEDIA_PATH ]] ; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| nzbToMedia Path             : INST_NZBTOMEDIA_PATH"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_NZBTOMEDIA_PATH == "" ]] )
    do
      printf '.\n'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
  printf "$PRINTF_MASK" "autoProcessMedia.cfg detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
else
  printf "$PRINTF_MASK" "autoProcessMedia.cfg not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults
  
  if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf "$PRINTF_MASK" "autoProcessMedia.cfg not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
    
    cp $INST_NZBTOMEDIA_PATH/nzbToMedia/autoProcessMedia.cfg.sample ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
    echo "-----------------------------------------------------------"
    echo "| Modify the following:"
    echo "-----------------------------------------------------------"
    echo "| [CouchPotato]"
    echo "| apikey    =  $INST_COUCHPOTATO_KEY_API"
    echo "| port      =  $INST_COUCHPOTATO_PORT"
#    echo "| "
#    echo "| [SickBeard]"
#    echo "| port      =  $INST_SICKBEARD_PORT"
#    echo "| username  = $INST_SICKBEARD_UID"
#    echo "| password  = $INST_SICKBEARD_PW"
    echo "-----------------------------------------------------------"
    echo "| Save"
    echo "-----------------------------------------------------------"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
    else
      open -a /Applications/TextWrangler.app ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
    fi
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
  else
    printf "$PRINTF_MASK" "autoProcessMedia.cfg detected" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -h ~/Library/Application\ Support/SABnzbd/scripts/nzbToCouchPotato.py ]; then
    printf "$PRINTF_MASK" "Symbolic link nzbToCouchPotato.py not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
    sudo ln -sfv $INST_NZBTOMEDIA_PATH/nzbToMedia/nzbToCouchPotato.py ~/Library/Application\ Support/SABnzbd/scripts/nzbToCouchPotato.py
  else
    printf "$PRINTF_MASK" "Symbolic link nzbToCouchPotato.py detected" "$GREEN" "[OK]" "$RESET"
  fi
  
  echo "-----------------------------------------------------------"
  echo "| Menu, Config, Categories:"
  echo "| movies, Default, Default, nzbToCouchpotato.py"
  echo "|----------"
  echo "| Save"
  echo "-----------------------------------------------------------"
  open http://localhost:8080/config/categories/
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
fi
