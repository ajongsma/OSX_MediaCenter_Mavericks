#!/usr/bin/env bash
source config.sh

sudo touch /Library/Server/Web/Config/php/php_xdebug.ini
echo "Don't forget to add 'zend_extension=/usr/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so' to /Library/Server/Web/Config/php/php_xdebug.ini"
#sudo echo "zend_extension=/usr/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so" > /Library/Server/Web/Config/php/php_xdebug.ini
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

sudo apachectl graceful
