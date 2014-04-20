#!/usr/bin/env bash
source config.sh

if [ ! -h $INST_APACHE_SYSTEM_WEB_ROOT/newznab ] ; then
  printf "$PRINTF_MASK" "-> NewzNAB not detected" "$RED" "[ERR]" "$RESET"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  exit 1
else
  printf "$PRINTF_MASK" "-> NewzNAB detected, extra settings..." "$YELLOW" "[WAIT]" "$RESET"
  
  echo "-----------------------------------------------------------"
  echo "| Modifying Blacklist"
  echo "-----------------------------------------------------------"
  echo "| alt.binaries.*"
  echo "| RegEx                         : german|danish|flemish|french|swedish|swesub|deutsch|norwegian|\.ita\."
  echo "| Description                   : do not index non-english language binaries except Dutch"
  echo "| Active                        : Yes"
  echo "-----------------------------------------------------------"
  echo "| Save"
  echo "-----------------------------------------------------------"
  open http://pooky.local/NewzNAB/admin/binaryblacklist-edit.php?id=1
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Site Edit, Spotnab Settings"
  echo "-----------------------------------------------------------"
  echo "| Auto Discovery                : Yes"
  echo "-----------------------------------------------------------"
  echo "| Save Settings"
  echo "-----------------------------------------------------------"
  open http://pooky.local/NewzNAB/admin/site-edit.php
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s


  printf "$PRINTF_MASK" "-> NewzNAB detected, extra settings - Complete" "$GREEN" "[OK]" "$RESET"
fi
