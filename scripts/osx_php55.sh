#!/usr/bin/env bash
source config.sh

if [ ! -e /usr/local/bin/brew ] ; then
  printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
  exit 1
else
  printf "$PRINTF_MASK" "Installing extra utilities" "$RED" "[ERR]" "$RESET"
  
  brew update
  brew upgrade
  
  brew install php55
  
  ## vim ~/.bash_profile
  ## export PATH="$(brew --prefix josegonzalez/php/php55)/bin:/usr/local/bin:$PATH"
  ##
  ## sudo vim /etc/apache2/httpd.conf
  ## LoadModule php5_module /usr/local/opt/php55/libexec/apache2/libphp5.so
  ##
  ## sudo apachectl gracefull
  ## php -v
  
  
  
  
fi
