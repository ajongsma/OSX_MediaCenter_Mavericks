#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_TRAKT_UID ]] || [[ -z $INST_TRAKT_PW ]] || [[ -z $INST_TRAKT_KEY_API ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| SABNzbd username  : INST_TRAKT_UID"
    echo "| SABnzbd password  : INST_TRAKT_PW"
    echo "| SABnzbd API Key   : INST_TRAKT_KEY_API"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_TRAKT_UID == "" ]] || [[ $INST_TRAKT_PW == "" ]] || [[ $INST_TRAKT_KEY_API == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" ".\n" "$GREEN" "[OK]" "$RESET"
  fi
}

check_config_defaults
printf "$PRINTF_MASK" "-> Configuring CouchPotato to TraktTV..." "$YELLOW" "[WAIT]" "$RESET"
echo "-----------------------------------------------------------"
echo "| Settings -> Automation - Watchlist"
echo "-----------------------------------------------------------"
echo "| Trakt                 : Enable"
echo "| - API Key             : $INST_TRAKT_KEY_API"
echo "| - Username            : $INST_TRAKT_UID"
echo "| - Password            : $INST_TRAKT_PW"
echo "-----------------------------------------------------------"
echo "| Test, Save"
echo "-----------------------------------------------------------"
open http://pooky.local:8082/settings/automation/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

printf "$PRINTF_MASK" "-> Configuring CouchPotato to TraktTV - Complete" "$GREEN" "[OK]" "$RESET"
