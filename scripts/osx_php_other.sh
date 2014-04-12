#!/usr/bin/env bash
source config.sh


echo "-----------------------------------------------------------"
echo "| /etc/php.ini"
echo "| - Section Paths and Directories"
echo "-----------------------------------------------------------"
echo "| Change            : max_execution_time = 60"
echo "| Change            : memory_limit = 256
echo "-----------------------------------------------------------"
echo "| Save changes"
echo "-----------------------------------------------------------"
if [ ! -d /Applications/TextWrangler.app ]; then
  sudo pico /etc/php.ini
else
  sudo open -a /Applications/TextWrangler.app /etc/php.ini
fi
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

sudo apachectl graceful
