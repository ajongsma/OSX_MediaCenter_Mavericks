#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing Plex Media Server"
echo "#------------------------------------------------------------------------------"

if [ ! -e /Applications/Plex\ Media\ Server.app ] ; then
  printf "$PRINTF_MASK" "Plex Media Server not installed, please install..." "$RED" "[FAIL]" "$RESET"
  open https://plex.tv/downloads
  while ( [ ! -e /Applications/PlexMediaServer.app ] )
  do
    printf "$PRINTF_MASK" "Waiting for Plex Media Server to be installed…" "$YELLOW" "[WAIT]" "$RESET"
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

  open /Applications/Plex\ Media\ Server.app
else
  printf "$PRINTF_MASK" "Plex Media Server found" "$GREEN" "[OK]" "$RESET"
fi


#
#if [ -e /Applications/Plex\ Media\ Server.app ] ; then
#    printf 'Plex Server found\n' "$GREEN" $col '[OK]' "$RESET"
#    open /Applications/Plex\ Media\ Server.app
#else
#    printf 'Plex Server not installed, something went wrong\n' "$RED" $col '[FAIL]' "$RESET"
#    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#    read -n 1 -s
#    exit
#fi

echo "#------------------------------------------------------------------------------"
echo "# Installing Plex Media Server - Complete"
echo "#------------------------------------------------------------------------------"
