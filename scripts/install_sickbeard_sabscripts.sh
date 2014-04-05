#!/usr/bin/env bash
source config.sh

if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg ] ; then
  printf "$PRINTF_MASK" "-> SickBeard to SABnzbd config detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "-> SickBeard to SABnzbd config not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"

  if [ -f ~/Library/Application\ Support/SABnzbd/scripts/sabToSickBeard.py ] ; then
    printf "$PRINTF_MASK" "Sickbeard default SABnzbd scripts detected" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "Sickbeard default SABnzbd scripts not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    cp -iv /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/
  fi
  
  if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg ] ; then
    printf "$PRINTF_MASK" "Sickbeard config file detected" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "Sickbeard config file not detected, creating..." "$GREEN" "[OK]" "$RESET"
    cp -iv ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg.sample ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg
    if [ "$?" != "0" ]; then
      echo -e "${RED}  ============================================== ${RESET}"
      echo -e "${RED} | ERROR ${RESET}"
      echo -e "${RED} | Copy failed: ${RESET}"
      echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
      echo -e "${RED} | --- press any key to continue --- ${RESET}"
      echo -e "${RED}  ============================================== ${RESET}"
      read -n 1 -s
      exit 1
    else
      printf "$PRINTF_MASK" "autoProcessTV.cfg copied" "$GREEN" "[OK]" "$RESET"
    fi
    
    echo "-----------------------------------------------------------"
    echo "| Add the following to [SickBeard]:"
    echo "| host                                    : localhost"
    echo "| Port                                    : $INST_SICKBEARD_PORT"
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
