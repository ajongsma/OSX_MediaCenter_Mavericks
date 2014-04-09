#!/usr/bin/env bash
source config.sh

######################################################################################
######################################## TODO ########################################
######################################################################################


if [ -d /Applications/MacPAR\ deLuxe.app ] ; then
  printf "$PRINTF_MASK" "MAcPAR Deluxe detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "MAcPAR Deluxe not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"

  #cd ~/Downloads
  #curl -O http://www.xs4all.nl/~gp/MacPAR_deLuxe/MacPARdeLuxe.dmg
  open http://www.xs4all.nl/~gp/MacPAR_deLuxe

  printf "$PRINTF_MASK" "Waiting for MacPAR to be downloaded…" "$YELLOW" "[WAIT]" "$RESET"
  while ( [ ! -e ~/Downloads/MacPARdeLuxe.dmg ] )
  do
      printf '.'
      sleep 3
  done
  printf ".\n"
  
  printf "$PRINTF_MASK" "MAcPAR Deluxe downloaded" "$GREEN" "[OK]" "$RESET"

  hdiutil attach ~/Downloads/MacPARdeLuxe.dmg
  cp -R /Volumes/MacPAR\ deLuxe/MacPAR\ deLuxe.app/ /Applications/MacPAR\ deLuxe.app/
  hdiutil detach /Volumes/MacPAR\ deLuxe/
  
  open /Applications/MacPAR\ deLuxe.app/
  printf "$PRINTF_MASK" "MAcPAR Deluxe installed" "$GREEN" "[OK]" "$RESET"
fi


