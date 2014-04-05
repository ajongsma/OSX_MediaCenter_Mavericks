#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
#  if [[ -z $INST_COUCHPOTATO_UID ]] || [[ -z $INST_COUCHPOTATO_PW ]] || [[ -z $INST_COUCHPOTATO_PORT ]]; then
#    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
#    echo "| username          : $INST_COUCHPOTATO_UID"
#    echo "| password          : $INST_COUCHPOTATO_PW"
#    echo "| port              : $INST_COUCHPOTATO_PORT"
#    if [ ! -d /Applications/TextWrangler.app ]; then
#      pico config.sh
#    else
#      open -a /Applications/TextWrangler.app config.sh
#    fi
#    while ( [[ $INST_COUCHPOTATO_UID == "" ]] || [[ $INST_COUCHPOTATO_PW == "" ]] || [[ $INST_COUCHPOTATO_PORT == "" ]] )
#    do
#      printf '.'
#      sleep 2
#      source config.sh
#    done
#    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
#  fi
}


if [ -e /usr/local/bin/cheetah ] ; then
  printf "$PRINTF_MASK" "-> Cheetah detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
else
  printf "$PRINTF_MASK" "-> Cheetah not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults

  echo "Download latest Cheetah from http://www.cheetahtemplate.org/download"
  open http://www.cheetahtemplate.org/download

  cd ~/Downloads
  printf 'Waiting for Cheetah to be downloaded…' "$YELLOW" $col '[WAIT]' "$RESET"
  while ( [ ! -e Cheetah-2.4.4.tar ] )
  do
      printf '.'
      sleep 2
  done
  printf 'Cheetah downloaded, installing...' "$YELLOW" $col '[WAIT]' "$RESET"
  tar xvzf Cheetah-2.4.4.tar
  cd Cheetah-2.4.4
  sudo python setup.py install

  if [ -e /usr/local/bin/cheetah ] ; then
    printf "$PRINTF_MASK" "-> Cheetah installed" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "-> Cheetah not installed" "$RED" "[ERR]" "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
  fi
  
  cd $DIR
fi
