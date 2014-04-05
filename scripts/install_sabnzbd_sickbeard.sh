#!/usr/bin/env bash
source config.sh

printf "$PRINTF_MASK" "-> Configuring SABnzbd to SickBeard..." "$YELLOW" "[WAIT]" "$RESET"

echo "-----------------------------------------------------------"
echo "| Menu, Config, Categories:"
echo "| tv, Default, Default, nzbToSickbeard.py"
echo "-----------------------------------------------------------"
open http://localhost:8080/config/categories/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

printf "$PRINTF_MASK" "-> Configuring SABnzbd to SickBeard - Complete" "$GREEN" "[OK]" "$RESET"
