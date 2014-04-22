#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [ ! -e /usr/local/bin/brew ] ; then
    printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
  fi
}


#INST_PLEX_SPOTIFY_PATH="/Users/Plex"


## https://github.com/Burgestrand/spotify/wiki

if [ -h /Library/Application Support/Plex Media Server/Plug-ins/Spotify.bundle ] ; then
  printf "$PRINTF_MASK" "Spotify bundle (symlinked) detected" "$GREEN" "[OK]" "$RESET"
else
  check_config_defaults
  
  if [ -d /Library/Application Support/Plex Media Server/Plug-ins/Spotify.bundle ] ; then
    printf "$PRINTF_MASK" "Old Spotify bundle detected" "$YELLOW" "[WAIT]" "$RESET"
  else
    printf "$PRINTF_MASK" "Old Spotify bundle not detected" "$GREEN" "[OK]" "$RESET"
  fi
  brew install libspotify
fi


