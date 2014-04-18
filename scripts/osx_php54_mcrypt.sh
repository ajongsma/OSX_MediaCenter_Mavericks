#!/usr/bin/env bash
source config.sh

### TESTING SUCCESFULL => TODO: CREATE PROPER SCRIPT

## http://www.gigoblog.com/2013/11/14/add-mcrypt-php-extension-to-mac-os-x-mavericks-server/
## INST_APACHE_SYSTEM_WEB_ROOT   : "/Library/Server/Web/Data/Sites/Default"
## extension_dir                 : /usr/lib/php/extensions/no-debug-non-zts-20100525
## Loaded Configuration File     : /etc/php.ini
## Additional .ini files parsed  : /Library/Server/Web/Config/php/php.ini

## /usr/local/etc/php/5.4/conf.d/ext-mcrypt.ini
## extension=/opt/local/lib/php54/extensions/no-debug-non-zts-20100525/mcrypt.so

brew update
brew upgrade
brew install php54-mcrypt

sudo cp /usr/local/Cellar/php54-mcrypt/5.4.27/mcrypt.so /usr/lib/php/extensions/no-debug-non-zts-20100525/
sudo cp config/php/php_mcrypt.ini /Library/Server/Web/Config/php/

sudo apachectl graceful
