#!/usr/bin/env bash
source config.sh

## http://thegeekywizard.com/2014/02/how-to-install-php5-5-mysql-mcrypt-phpmyadmin-on-osx-mavericks-using-homebrew/

if [ ! -e /usr/local/bin/brew ] ; then
  printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
  exit 1
else
  printf "$PRINTF_MASK" "Installing extra utilities" "$RED" "[ERR]" "$RESET"
  
  brew tap josegonzalez/homebrew-php
  
  brew update
  brew upgrade
  
  brew install php55 --with-apache
  
  #cp /usr/local/Cellar/php55/5.5.11/libexec/apache2/libphp5.so
  
  ## vim ~/.bash_profile
  ## export PATH="$(brew --prefix josegonzalez/php/php55)/bin:/usr/local/bin:$PATH"
  ##
  ## sudo vim /etc/apache2/httpd.conf
  ## LoadModule php5_module /usr/local/opt/php55/libexec/apache2/libphp5.so
  ##
  ## sudo apachectl gracefull
  ## php -v
fi


## The php.ini file can be found in:
##     /usr/local/etc/php/5.5/php.ini
## 
## ✩✩✩✩ PEAR ✩✩✩✩
## 
## If PEAR complains about permissions, 'fix' the default PEAR permissions and config:
##     chmod -R ug+w /usr/local/Cellar/php55/5.5.11/lib/php
##     pear config-set php_ini /usr/local/etc/php/5.5/php.ini
## 
## ✩✩✩✩ Extensions ✩✩✩✩
## 
## If you are having issues with custom extension compiling, ensure that
## you are using the brew version, by placing /usr/local/bin before /usr/sbin in your PATH:
## 
##       PATH="/usr/local/bin:$PATH"
## 
## PHP55 Extensions will always be compiled against this PHP. Please install them
## using --without-homebrew-php to enable compiling against system PHP.
## 
## ✩✩✩✩ PHP CLI ✩✩✩✩
## 
## If you wish to swap the PHP you use on the command line, you should add the following to ~/.bashrc,
## ~/.zshrc, ~/.profile or your shell's equivalent configuration file:
## 
##       export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
## 
## To have launchd start php55 at login:
##     ln -sfv /usr/local/opt/php55/*.plist ~/Library/LaunchAgents
## Then to load php55 now:
##     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.php55.plist
