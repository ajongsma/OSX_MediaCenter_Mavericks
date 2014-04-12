#!/usr/bin/env bash
source config.sh

cd /usr/lib/php
#sudo php -d detect_unicode=0 go-pear.phar
#sudo php install-pear-nozlib.phar
sudo php -d detect_unicode=0 install-pear-nozlib.phar

# include_path = ".:/usr/lib/php/:/usr/lib/php/pear/"
echo "-----------------------------------------------------------"
echo "| /etc/php.ini"
echo "| - Section Paths and Directories"
echo "-----------------------------------------------------------"
echo "| Add               : include_path = \".:/usr/lib/php/:/usr/lib/php/pear/\""
echo "-----------------------------------------------------------"
echo "| Save changes"
echo "-----------------------------------------------------------"
osascript -e 'tell app "Terminal"
      do script "sudo pico /etc/php.ini"
  end tell'
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

sudo apachectl graceful


cd $DIR
