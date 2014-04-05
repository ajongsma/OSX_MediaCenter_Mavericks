#!/usr/bin/env bash
source config.sh

printf "$PRINTF_MASK" "-> Configuring SickBeard to Plex Media Server..." "$YELLOW" "[WAIT]" "$RESET"

echo "-----------------------------------------------------------"
echo "| Plex Media Server     : Enable"
echo "| - Notify on Download  : Enable"
echo "| - Update Library      : Enable"
echo "| - Server IP:Port      : 127.0.0.1:32400"
echo "| - Client IP:Port      : 127.0.0.1:3000"
echo "| - Plex Client Username: ??"
echo "| - Plex Client Password: ??"
echo "-----------------------------------------------------------"
echo "| Test, Save"
echo "-----------------------------------------------------------"
open http://pooky.local:8081/config/notifications/
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

printf "$PRINTF_MASK" "-> Configuring SickBeard to Plex Media Server - Complete" "$GREEN" "[OK]" "$RESET"
