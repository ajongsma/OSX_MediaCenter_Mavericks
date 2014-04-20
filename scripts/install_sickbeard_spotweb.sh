#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_SPOTWEB_KEY_API_SICKBEARD ]]; then
      echo "-----------------------------------------------------------"
      echo "| Please add the Sickbeard Spotweb API key to config.sh"
      echo "| API Key                              : INST_SPOTWEB_KEY_API_SICKBEARD <paste value> "
      echo "-----------------------------------------------------------"
      #open http://localhost/newznab/admin/site-edit.php
      http://localhost/spotweb/?page=render&tplname=usermanagement
      subl ../config.sh
  
      while ( [[ $INST_SPOTWEB_KEY_API_SICKBEARD == "" ]] )
      do
          printf 'Waiting for Sickbeard Spotweb API be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
          sleep 2
          source ../config.sh
      done
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
  echo "| "
  echo "| Configure Custom Newznab Providers:"
  echo "| Provider Name                           : Spotweb"
  echo "| Site URL                                : http://localhost/spotweb/"
  echo "| API Key                                 : $INST_SPOTWEB_KEY_API_SICKBEARD"
  echo "-------------------------------"
  echo "| Save changes"
  echo "-----------------------------------------------------------"
  open http://localhost:8081/config/providers/
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  printf "$PRINTF_MASK" "-> Configuring Sickbeard to SpotWEB complete" "$GREEN" "[OK]" "$RESET"
fi
