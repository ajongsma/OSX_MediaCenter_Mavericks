#!/usr/bin/env bash
source config.sh

printf "$PRINTF_MASK" "-> Configuring SickBeard to TraktTV..." "$YELLOW" "[WAIT]" "$RESET"
echo "-----------------------------------------------------------"
echo "| SickBeard -> Config -> Notifications"
echo "-----------------------------------------------------------"
echo "| Trakt                 : Enable"
echo "| - Trakt Username      : $INST_TRAKT_UID"
echo "| - Trakt Password      : $INST_TRAKT_PW"
echo "| - Trakt API           : $INST_TRAKT_KEY_API"
echo "-----------------------------------------------------------"
echo "| Test, Save"
echo "-----------------------------------------------------------"
open http://pooky.local:8081/config/notifications/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

printf "$PRINTF_MASK" "-> Configuring SABnzbd to SickBeard - Complete" "$GREEN" "[OK]" "$RESET"
