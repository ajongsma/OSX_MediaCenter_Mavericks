#!/usr/bin/env bash
source config.sh

if [ -d /Applications/Sequel\ Pro.app ] ; then
  printf "$PRINTF_MASK" "Sequel Pro detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "Sequel Pro not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"

  open https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg

  printf "$PRINTF_MASK" "Waiting for Sequel Pro to be downloaded…" "$YELLOW" "[WAIT]" "$RESET"
  while ( [ ! -e ~/Downloads/sequel-pro-1.0.2.dmg ] )
  do
    printf '.'
    sleep 3
  done
  printf ".\n"
  
  printf "$PRINTF_MASK" "Sequel Pro downloaded" "$GREEN" "[OK]" "$RESET"

  hdiutil attach ~/Downloads/sequel-pro-1.0.2.dmg
  cp -R /Volumes/sequel-pro\Sequel\ Pro.app/ /Applications/Sequel\ Pro.app/
  hdiutil detach /Volumes/Sequel\ Pro/
  
  open /Applications/Sequel\ Pro.app/
  printf "$PRINTF_MASK" "MAcPAR Deluxe installed" "$GREEN" "[OK]" "$RESET"
fi
