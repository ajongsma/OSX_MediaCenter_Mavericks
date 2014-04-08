
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

echo "Don't forget to add 'extension=gettext.so' to /etc/php.ini"
 
