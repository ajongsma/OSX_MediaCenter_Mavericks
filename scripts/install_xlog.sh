#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing XLog"
echo "#------------------------------------------------------------------------------"

if [ ! -e /Applications/xlog.app ] ; then
  printf "$PRINTF_MASK" "XLog not installed, please install..." "$RED" "[FAIL]" "$RESET"
  open https://itunes.apple.com/nl/app/xlog/id430304898?l=en&mt=12
  while ( [ ! -e /Applications/Xlog.app ] )
  do
    printf "$PRINTF_MASK" "Waiting for XLog to be installed…" "$YELLOW" "[WAIT]" "$RESET"
    sleep 15
  done
  
#  printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
#  printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
#  printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"
  open /Applications/Xlog.app
  
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
else
  printf "$PRINTF_MASK" "XLOG found" "$GREEN" "[OK]" "$RESET"
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing XLog - Complete"
echo "#------------------------------------------------------------------------------"
