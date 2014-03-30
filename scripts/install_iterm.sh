#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing iTerm 2"
echo "#------------------------------------------------------------------------------"

if [ ! -e /Applications/iterm.app ] ; then
  printf "$PRINTF_MASK" "iTerm not installed, please install..." "$RED" "[FAIL]" "$RESET"
  open https://www.iterm2.com
  while ( [ ! -e /Applications/iterm.app ] )
  do
    printf "$PRINTF_MASK" "Waiting for iTerm to be installed…" "$YELLOW" "[WAIT]" "$RESET"
    sleep 15
  done

  open /Applications/iterm.app
else
  printf "$PRINTF_MASK" "iTerm 2 found" "$GREEN" "[OK]" "$RESET"
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing iTerm 2 - Complete"
echo "#------------------------------------------------------------------------------"
