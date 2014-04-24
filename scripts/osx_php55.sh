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
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-intl not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-intl detected" "$GREEN" "[OK]" "$RESET"
    fi
    brew install php55-mcrypt
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-mcrypt not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-mcrypt detected" "$GREEN" "[OK]" "$RESET"
    fi
    brew install php55-memcached
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-memcached not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-memcached detected" "$GREEN" "[OK]" "$RESET"
    fi
    brew install php55-propro
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-propro not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-propro detected" "$GREEN" "[OK]" "$RESET"
    fi
    brew install php55-raphf
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-raphf not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-raphf detected" "$GREEN" "[OK]" "$RESET"
    fi
    brew install php55-http
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-http not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-http detected" "$GREEN" "[OK]" "$RESET"
    fi
    brew install php55-ssh2
    if [ ! -d /usr/local/Cellar/php55/todo ] ; then
      printf "$PRINTF_MASK" "php55-ssh2 not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    else
      printf "$PRINTF_MASK" "php55-ssh2 detected" "$GREEN" "[OK]" "$RESET"
    fi
  
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
      echo "export PATH=\"\$(brew --prefix josegonzalez/php/php55)/bin:/usr/local/bin:\$PATH\"" >> ~/.bash_profile
      #echo "export PATH=\"\$PATH:/usr/local\"" >> ~/.bash_profile
    fi

#################################
############ TESTING ############
#################################

#################################
## Hmmm
#cp $HOMEBREW_PREFIX/Cellar/php55/5.5.11/homebrew.mxcl.php55.plist ~/Library/LaunchAgents/
#launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php54.plist
#launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist
#######
## Swapping from PHP 5.4 to PHP 5.5
## export PATH="$(brew --prefix homebrew/php/php54)/bin:$PATH"
#export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
#######
## PEAR Extensions
# export PATH="$(brew --prefix php55)/bin:$PATH"
#######
#################################

echo " ==> Checking PEAR's directory"
pear config-get php_dir
#pear config-set php_dir /usr/lib/php
echo " ==> Check that correct php.ini is used"
php --ini
echo " ==> Check include_path in the php.ini"
php -c /path/to/php.ini -r 'echo get_include_path() . "\n";'
echo " ==> Add include_path to the php.ini"
#include_path = ".:/usr/lib/php/pear"
#include_path = "/usr/local/PEAR:/php/includes"
echo " --- press any key to continue ---"
read -n 1 -s

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
