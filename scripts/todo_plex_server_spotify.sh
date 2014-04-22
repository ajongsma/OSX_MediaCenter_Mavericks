#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_PLEX_SPOTIFY_PATH ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| Plex Spotify Path             : INST_PLEX_SPOTIFY_PATH"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_PLEX_SPOTIFY_PATH == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" ".\n" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -e /usr/local/bin/brew ] ; then
    printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
  fi
}

#INST_PLEX_SPOTIFY_PATH="/Users/Plex"

#################################################################################### 
## ERROR (logkit:22) - There was a problem authenticating, authentication failed
##  You will need to set a device password at
##  http://www.spotify.com/account/set-device-password/
####################################################################################

## https://github.com/Burgestrand/spotify/wiki

if [ -h ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Spotify.bundle ] ; then
  printf "$PRINTF_MASK" "Spotify bundle (symlinked) detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "Spotify bundle (symlinked) not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults
  
  if [ -d ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Spotify.bundle ] ; then
    printf "$PRINTF_MASK" "Old Spotify bundle detected, removing..." "$YELLOW" "[WAIT]" "$RESET"
    rm -Rf ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Spotify.bundle
    if [ $? != 0 ]; then
      echo -e "${BLUE} --- press any key to continue --- ${RESET}"
      read -n 1 -s
      printf "$PRINTF_MASK" "Old Spotify bundle not removed succesfully" "$RED" "[ERR]" "$RESET"
      exit 1
    else
      printf "$PRINTF_MASK" "Old Spotify bundle removed succesfully" "$GREEN" "[OK]" "$RESET"
    fi
  else
    printf "$PRINTF_MASK" "Old Spotify bundle not detected" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ -d /usr/local/Cellar/libspotify ] ; then
    printf "$PRINTF_MASK" "libspotify detected" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "libspotify not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    brew install libspotify
  fi
  
  if [ ! -d $INST_PLEX_SPOTIFY_PATH ] ; then
    printf "$PRINTF_MASK" $INST_PLEX_SPOTIFY_PATH" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_PLEX_SPOTIFY_PATH
    sudo chown `whoami`:staff $INST_PLEX_SPOTIFY_PATH
  else
    printf "$PRINTF_MASK" $INST_PLEX_SPOTIFY_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi

  if [ ! -d $INST_PLEX_SPOTIFY_PATH/Spotify.bundle ] ; then
    printf "$PRINTF_MASK" "Spotify.bundle doesn't exists, downloading respository..." "$YELLOW" "[WAIT]" "$RESET"
    
    cd $INST_PLEX_SPOTIFY_PATH
    git clone https://github.com/Tim-B/Spotify.bundle.git
    ln -s $INST_PLEX_SPOTIFY_PATH/Spotify.bundle ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Spotify.bundle
    if [ $? != 0 ]; then
      printf "$PRINTF_MASK" "Something went wrong with the symlink" "$RED" "[ERR]" "$RESET"
    else
      printf "$PRINTF_MASK" "Symlink OK" "$GREEN" "[OK]" "$RESET"
    fi
  else
    printf "$PRINTF_MASK" "Spotify.bundle exists" "$GREEN" "[OK]" "$RESET"
  fi


  cd $DIR
  printf "$PRINTF_MASK" "Spotify bundle (symlinked) installed" "$GREEN" "[OK]" "$RESET"
fi


