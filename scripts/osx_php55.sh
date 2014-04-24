#!/usr/bin/env bash
source config.sh

## http://thegeekywizard.com/2014/02/how-to-install-php5-5-mysql-mcrypt-phpmyadmin-on-osx-mavericks-using-homebrew/
if [ ! -e /usr/local/bin/brew ] ; then
  printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
  echo " --- press any key to continue ---"
  read -n 1 -s
  exit 1
else
  if [ ! -d /usr/local/Cellar/php55 ] ; then
    printf "$PRINTF_MASK" "PHP 5.5 detected" "$RED" "[ERR]" "$RESET"
  else
    printf "$PRINTF_MASK" "PHP 5.5 not detected, installing..." "$RED" "[ERR]" "$RESET"
    
    brew tap josegonzalez/homebrew-php
    brew update
    brew upgrade
    
    brew install php55 --with-apache
    
    export PATH="$(brew --prefix josegonzalez/php/php55)/bin:/usr/local/bin:$PATH"
    
    brew install php55-intl
    brew install php55-mcrypt
    brew install php55-memcached
    brew install php55-propro
    brew install php55-raphf
    brew install php55-http
    brew install php55-ssh2
  
    sudo mv /usr/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp54.so
    sudo ln -sv /usr/local/Cellar/php55/5.5.11/libexec/apache2/libphp5.so /usr/libexec/apache2/libphp5.so
    
    cp /usr/local/etc/php/5.5/php.ini /usr/local/etc/php/5.5/php.ini.org
    sed -i -r 's/^;date.timezone =.*/date.timezone = Europe\/Amsterdam/' /usr/local/etc/php/5.5/php.ini
    sudo apachectl graceful    

    if [ -f ~/.bash_profile ] ; then
      printf "$PRINTF_MASK" "Existing bash profile not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
      echo " ==>"
      echo " ==> TODO"
      echo " ==>"
      echo " --- press any key to continue ---"
      read -n 1 -s
    else
      printf "$PRINTF_MASK" "Existing bash profile detected, appending..." "$YELLOW" "[WAIT]" "$RESET"
      echo "export PATH="$(brew --prefix josegonzalez/php/php55)/bin:/usr/local/bin:$PATH"" >> ~/.bash_profile
    fi
    

    sh /usr/local/Cellar/php55/5.5.11/bin/php retrieve.php
    
    #/usr/local/etc/php/5.5/php.ini
    
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
