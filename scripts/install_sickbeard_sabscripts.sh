#!/usr/bin/env bash
source config.sh

if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg ] ; then
  printf "$PRINTF_MASK" "-> SickBeard to SABnzbd config detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "-> SickBeard to SABnzbd config not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"

  if [ -f ~/Library/Application\ Support/SABnzbd/scripts/sabToSickBeard.py ] ; then
    printf 'Sickbeard default SABnzbd scripts installed\n' "$GREEN" $col '[OK]' "$RESET"
  else
    printf 'Sickbeard default SABnzbd scripts installed not installed\n' "$RED" $col '[FAIL]' "$RESET"
    cp -iv /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/
  fi
  
  if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg ] ; then
    printf 'Sickbeard config file installed\n' "$GREEN" $col '[OK]' "$RESET"
  else
    printf 'Sickbeard config file scripts installed not installed\n' "$RED" $col '[FAIL]' "$RESET"
    cp -iv /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/
      
      
    echo "-----------------------------------------------------------"
    echo "| Add the following to [SickBeard]:"
    echo "| host                                    : localhost"
    echo "| Port                                    : 8081"
    echo "| username                                : $INST_SICKBEARD_UID"
    echo "| password                                : $INST_SICKBEARD_PW"
    echo "-----------------------------------------------------------"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg
    else
      open -a /Applications/TextWrangler.app ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg
    fi
    
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
  fi

fi

##### TESTING #####
exit 0
##### TESTING #####



echo "#------------------------------------------------------------------------------"
echo "# Configuring default Sick-Beard to SABnzbd scripts"
echo "#------------------------------------------------------------------------------"







echo "#------------------------------------------------------------------------------"
echo "# Configuring default Sick-Beard to SABnzbd scripts"
echo "#------------------------------------------------------------------------------"
