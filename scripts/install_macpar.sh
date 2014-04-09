#!/usr/bin/env bash
source config.sh

######################################################################################
######################################## TODO ########################################
######################################################################################


if [ -e /Applications/MacPAR.app ] ; then
  printf "$PRINTF_MASK" "MAcPAR Deluxe detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "MAcPAR Deluxe not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"

  cd ~/Downloads
  curl -O http://www.xs4all.nl/~gp/MacPAR_deLuxe/MacPARdeLuxe.dmg

  printf "$PRINTF_MASK" "Waiting for MacPAR to be downloaded…" "$YELLOW" "[WAIT]" "$RESET"
  while ( [ ! -e ~/Downloads/MacPARdeLuxe.dmg ] )
  do
      printf '.'
      sleep 3
  done
  printf ".\n"
  
  printf "$PRINTF_MASK" "MAcPAR Deluxe downloaded" "$GREEN" "[OK]" "$RESET"

  hdiutil attach MacPARdeLuxe.dmg
  cd /Volumes/MacPARdeLuxe.pkg
  #installer -pkg MacPARdeLuxe.pkg -target "/"
  open MacPARdeLuxe.pkg
  
  hdiutil detach /Volumes/MacPARdeLuxe.pkg/
    

  cd $DIR
fi


