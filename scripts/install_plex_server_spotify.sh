#!/usr/bin/env bash
source config.sh


if [ ! -e /Applications/Plex\ Media\ Server.app ] ; then
  printf "$PRINTF_MASK" "Plex Media Server not detected" "$RED" "[FAIL]" "$RESET"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  exit 1
else
  printf "$PRINTF_MASK" "Plex Media Server detected" "$GREEN" "[OK]" "$RESET"
fi


if [ -f libspotify ] ; then
  printf "$PRINTF_MASK" "libspotify detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "libspotify not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  if [ ! -e /usr/local/bin/brew ] ; then
    printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
  else
    brew install libspotify
  fi
fi

