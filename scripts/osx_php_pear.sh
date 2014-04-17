#!/usr/bin/env bash
source config.sh

cd /usr/lib/php

#sudo php install-pear-nozlib.phar
#sudo php -d detect_unicode=0 install-pear-nozlib.phar
sudo php install-pear-nozlib.phar

sudo pear channel-update pear.php.net
sudo pecl channel-update pecl.php.net
sudo pear upgrade-all
sudo pear config-set auto_discover 1

## include_path = ".:/usr/lib/php/:/usr/lib/php/pear/"
#echo "-----------------------------------------------------------"
#echo "| /etc/php.ini"
#echo "| - Section Paths and Directories"
#echo "-----------------------------------------------------------"
#echo "| Add               : include_path = \".:/usr/lib/php/:/usr/lib/php/pear/\""
#echo "-----------------------------------------------------------"
#echo "| Save changes"
#echo "-----------------------------------------------------------"
#osascript -e 'tell app "Terminal"
#      do script "sudo pico /etc/php.ini"
#  end tell'
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

sudo apachectl graceful


cd $DIR
