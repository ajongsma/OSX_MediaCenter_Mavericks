#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing Plex Home Theator"
echo "#------------------------------------------------------------------------------"

if [ ! -e /Applications/Plex\ Home\ Theater.app ] ; then
  printf "$PRINTF_MASK" "Plex Home Theater not installed, please install..." "$RED" "[FAIL]" "$RESET"
  open https://plex.tv/downloads
  while ( [ ! -e /Applications/Plex\ Home\ Theater.app ] )
  do
    printf "$PRINTF_MASK" "Waiting for Plex Home Theater to be installed…" "$YELLOW" "[WAIT]" "$RESET"
    sleep 15
    
#    if [ ! -e ~/Downloads/PlexMediaServer-* ] ; then
#        echo "Plex Server not installed, please install..."
#        open http://www.plex.tv/getplex
#        while ( [ ! -e ~/Downloads/PlexMediaServer-* ] )
#        do
#            echo "Waiting for Plex Server to be downloaded..."
#            sleep 15
#        done
#    else
#        echo "Plex Server download found                           [OK]"
#    fi
#
#    for i in ~/Downloads/PlexMediaServer-*; do
#        if [ -f "$i" ]; then
#            #echo "Found : $i"
#            open $i
#            if [ -e /Volumes/PlexMediaServer/Plex\ Media\ Server.app ] ; then
#                cp -R /Volumes/PlexMediaServer/Plex\ Media\ Server.app/ /Applications/
#            fi
#        fi
#    done
  done

  open /Applications/Plex\ Home\ Theater.app
  
  ##http://plex.tv/web/app#!/setup
  printf "$PRINTF_MASK" "Please note: only the keyboard functions (arrows, enter etc.)" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-> Click Next" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "Choose the correct audio output" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-> Click Next" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "Authenticate the Plex Home Theater on Plex.tv" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-> Click Next" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
  
  open http://plex.tv/pin
  printf "$PRINTF_MASK" "Enter the PIN on Plex.tv" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-> Click Next" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
  printf "$PRINTF_MASK" "Click OK" "$YELLOW" "[WAIT]" "$RESET"
  
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
else
  printf "$PRINTF_MASK" "Plex Home Theater found" "$GREEN" "[OK]" "$RESET"
fi


#
#if [ -e /Applications/Plex\ Home\ Theater.app ] ; then
#    printf 'Plex Home Theater found\n' "$GREEN" $col '[OK]' "$RESET"
#    open /Applications/Plex\ Home\ Theater.app
#else
#    printf 'Plex Home Theater not installed, something went wrong\n' "$RED" $col '[FAIL]' "$RESET"
#    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#    read -n 1 -s
#    exit
#fi

echo "#------------------------------------------------------------------------------"
echo "# Installing Plex Home Theater - Complete"
echo "#------------------------------------------------------------------------------"
