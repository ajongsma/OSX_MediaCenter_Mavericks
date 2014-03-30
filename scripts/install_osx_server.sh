#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing OS X Server"
echo "#------------------------------------------------------------------------------"

if [ -e /Applications/Server.app ] ; then
  printf "$PRINTF_MASK" "OS X Server not installed, please install..." "$RED" "[FAIL]" "$RESET"
  #open https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12
  open https://itunes.apple.com/nl/app/os-x-server/id714547929?l=en&mt=12
  while ( [ ! -e /Applications/Server.app ] )
  do
    printf "$PRINTF_MASK" "Waiting for OS X Server to be installed…" "$YELLOW" "[WAIT]" "$RESET"
    sleep 15
  done
  printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"
  open /Applications/Server.app
  
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
else
  printf "$PRINTF_MASK" "OS X Server found" "$GREEN" "[OK]" "$RESET"
fi

SERVICE='httpd'
if ps ax | grep -v grep | grep $SERVICE > /dev/null ; then
  printf "$PRINTF_MASK" "$SERVICE' is running" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "$SERVICE' is not running" "$RED" "[FAIL]" "$RESET"
  
  printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"
  
  echo -e "${BLUE} --- press any key to abort --- ${RESET}"
  read -n 1 -s
  
  open /Applications/Server.app
  exit 1
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing OS X Server - Complete"
echo "#------------------------------------------------------------------------------"
