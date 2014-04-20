#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_SPOTWEB_KEY_API_SICKBEARD ]]; then
    echo "-----------------------------------------------------------"
    echo "| In the top-right corner, user icon, add user"
    echo "-----------------------------------------------------------"
    echo "| Username              : $INST_SICKBEARD_UID""_api"
    echo "| Firstname             : Sick"
    echo "| Lastname              : Beard"
    echo "| Email                 : sickbeard@localhost.local"
    echo "-----------------------------------------------------------"
    echo "| Click Add"
    echo "-----------------------------------------------------------"
    open http://localhost/spotweb
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    
    echo "-----------------------------------------------------------"
    echo "| Config, User and Group Management"
    echo "-----------------------------------------------------------"
    echo "| Click Username        : $INST_SICKBEARD_UID""_api"
    echo "| API Key               : INST_SPOTWEB_KEY_API_SICKBEARD <paste api value>"
    echo "-----------------------------------------------------------"
    open http://localhost/spotweb/?page=render\&tplname=usermanagement
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    
    printf 'Waiting for Sickbeard Spotweb API be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
    while ( [[ $INST_SPOTWEB_KEY_API_SICKBEARD == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" ".\n" "$GREEN" "[OK]" "$RESET"
  fi
}


if [ ! -h $INST_APACHE_SYSTEM_WEB_ROOT/spotweb ] ; then
  printf "$PRINTF_MASK" "-> Spotweb detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
  #check_config_var
else
  printf "$PRINTF_MASK" "-> Configuring Sickbeard to SpotWEB..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults
  
  echo "-----------------------------------------------------------"
  echo "| Menu, Config, Search Providers:"
  echo "-----------------------------------------------------------"
  echo "| Configure Custom Newznab Providers"
  echo "| Select Provider                         : Add new provider"
  echo "| Provider Name                           : Spotweb"
  echo "| Site URL                                : http://localhost/spotweb/"
  echo "| API Key                                 : $INST_SPOTWEB_KEY_API_SICKBEARD"
  echo "-----------------------------------------------------------"
  echo "| Add"
  echo "-----------------------------------------------------------"
  echo "| Drag the Spotweb provider to the top of the list"
  echo "-----------------------------------------------------------"
  echo "| Save Changes"
  echo "-----------------------------------------------------------"
  open http://localhost:8081/config/providers/
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  printf "$PRINTF_MASK" "-> Configuring Sickbeard to SpotWEB complete" "$GREEN" "[OK]" "$RESET"
fi
