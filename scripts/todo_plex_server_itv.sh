#!/usr/bin/env bash
source config.sh

if [ -f ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/iTVOnline.bundle ] ; then
  printf "$PRINTF_MASK" "Plex Media Server KPN iTV Online channel detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "Plex Media Server KPN iTV Online channel not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  
  cd ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
  git clone https://github.com/loek17/iTVOnline.bundle.git
  
  echo "|------------------------------------------------------------------------------"
  echo "| Don't forget to restart the Plex Media Server"
  echo "|------------------------------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  printf "$PRINTF_MASK" "Plex Media Server KPN iTV Online channel installed" "$GREEN" "[OK]" "$RESET"
  cd $DIR
fi
