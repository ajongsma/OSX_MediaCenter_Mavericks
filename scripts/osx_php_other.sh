#!/usr/bin/env bash
source config.sh


echo "-----------------------------------------------------------"
echo "| /etc/php.ini"
echo "| - Section Paths and Directories"
echo "-----------------------------------------------------------"
echo "| Change            : max_execution_time = 60"
echo "| Change            : memory_limit = 256M"
echo "-----------------------------------------------------------"
echo "| Save changes"
echo "-----------------------------------------------------------"
osascript -e 'tell app "Terminal"
  do script "sudo pico /etc/php.ini"
end tell'
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

sudo apachectl graceful
