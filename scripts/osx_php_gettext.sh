### TESTING SUCCESFULL => TODO: CREATE PROPER SCRIPT

# INST_APACHE_SYSTEM_WEB_ROOT   : "/Library/Server/Web/Data/Sites/Default"
# extension_dir                 : /usr/lib/php/extensions/no-debug-non-zts-20100525
# Loaded Configuration File     : /etc/php.ini
# Additional .ini files parsed  : /Library/Server/Web/Config/php/php.ini

# extension=/usr/lib/php/extensions/no-debug-non-zts-20100525/gettext.so

brew update
brew install autoconf
brew install gettext

curl -O http://nl1.php.net/distributions/php-5.4.24.tar.gz
tar -xvzf php-5.4.24.tar.gz

cd php-5.4.24/ext/gettext/
phpize
./configure --with-gettext=/usr/local/Cellar/gettext/0.18.3.2
make
sudo cp modules/gettext.so /usr/lib/php/extensions/no-debug-non-zts-20100525/

echo "Don't forget to add 'extension=gettext.so' to /Library/Server/Web/Config/php/php_gettext.ini"
#sudo touch /Library/Server/Web/Config/php/php_gettext.ini

#sudo echo "extension=gettext.so" > /Library/Server/Web/Config/php/php_gettext.ini
#sudo touch /Library/Server/Web/Config/php/php_xdebug.ini
#sudo echo "zend_extension=/usr/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so" > /Library/Server/Web/Config/php/php_xdebug.ini


sudo apachectl graceful
