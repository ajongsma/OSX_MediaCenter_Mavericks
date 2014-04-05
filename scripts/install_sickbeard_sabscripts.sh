#!/usr/bin/env bash
source config.sh

if [ -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg ] ; then
  printf "$PRINTF_MASK" "-> SickBeard to SABnzbd config detected\n" "$GREEN" "[OK]" "$RESET"
#  check_config_defaults
#  check_config_var
else
  printf "$PRINTF_MASK" "-> SickBeard to SABnzbd config not detected, installing...\n" "$YELLOW" "[WAIT]" "$RESET"
#  check_config_defaults



fi

##### TESTING #####
exit 0
##### TESTING #####



echo "#------------------------------------------------------------------------------"
echo "# Configuring default Sick-Beard to SABnzbd scripts"
echo "#------------------------------------------------------------------------------"



if [ -f ~/Library/Application\ Support/SABnzbd/scripts/sabToSickBeard.py ] ; then
    printf 'Sickbeard default SABnzbd scripts installed\n' "$GREEN" $col '[OK]' "$RESET"
else
    printf 'Sickbeard default SABnzbd scripts installed not installed\n' "$RED" $col '[FAIL]' "$RESET"

    cp -iv /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/
    cp -iv ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg.sample ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg
fi

echo "-----------------------------------------------------------"
echo "| Add the following to [SickBeard]:"
echo "| host                                    : localhost"
echo "| Port                                    : 8081"
echo "| username                                : $INST_SICKBEARD_UID"
echo "| password                                : $INST_SICKBEARD_PW"
echo "-----------------------------------------------------------"
subl ~/Library/Application\ Support/SABnzbd/scripts/autoProcessTV.cfg
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s


echo "#------------------------------------------------------------------------------"
echo "# Configuring default Sick-Beard to SABnzbd scripts"
echo "#------------------------------------------------------------------------------"
