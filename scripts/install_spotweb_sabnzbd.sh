#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_SABNZBD_KEY_API ]] ; then
    printf 'SabNZBD API key was not detected in config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| API               : $INST_COUCHPOTATO_KEY_API "
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_COUCHPOTATO_KEY_API == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

if [ ! -e /Applications/SABnzbd.app ] ; then
  printf "$PRINTF_MASK" "-> SabNZBD not detected" "$GREEN" "[OK]" "$RESET"
  exit 1
else

  echo "-----------------------------------------------------------"
  echo "| Goto                          : Config -> Change Preferences"
  echo "| Select tab                    : NZB Handling"
  echo "| NZB files?                    : Call SabNZBD through HTTP by Spotweb"
  echo "| Multiple NZB files?           : Merge NZB files"
  echo "| URL to SABnzbd                : http://localhost:$INST_SABNZBD_PORT"
  echo "| API key for SABnzbd           : $INST_SABNZBD_KEY_API"
  echo "| Username for sabnzbd?         : $INST_SABNZBD_UID"
  echo "| Password for sabnzbd?         : $INST_SABNZBD_PW"
  echo "-----------------------------------------------------------"
  echo "| Change"
  echo "-----------------------------------------------------------"
  open http://localhost/spotweb
  echo " --- press any key to continue ---"
  read -n 1 -s


fi
