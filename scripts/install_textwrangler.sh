#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing Textwrangler"
echo "#------------------------------------------------------------------------------"

if [ ! -e /Applications/textwrangler.app ] ; then
  printf "$PRINTF_MASK" "Plex Home Theater not installed, please install..." "$RED" "[FAIL]" "$RESET"
  open https://itunes.apple.com/nl/app/textwrangler/id404010395?l=en&mt=12
  while ( [ ! -e /Applications/textwrangler.app ] )
  do
    printf "$PRINTF_MASK" "Waiting for Plex Home Theater to be installed…" "$YELLOW" "[WAIT]" "$RESET"
    sleep 15
  done

  open /Applications/textwrangler.app
else
  printf "$PRINTF_MASK" "Textwrangler found" "$GREEN" "[OK]" "$RESET"
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing Textwrangler - Complete"
echo "#------------------------------------------------------------------------------"
