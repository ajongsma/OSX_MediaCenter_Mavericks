#!/usr/bin/env bash

source config.sh

#https://github.com/ecleese/plexWatchWeb.git
## Requirements:
## - Plex Media Server (v0.9.8+) and a PlexPass membership
## - plexWatch (v0.1.6+)
## - a web server that supports php (apache, nginx, XAMPP, WampServer, EasyPHP, lighttpd, etc)
## - php5
## - php5-sqlite
## - php5-curl
## - php5-json

if [ ! -f $INST_PLEXWATCHWEB_PATH/plexWatchWeb/index.php ] ; then
  echo "#------------------------------------------------------------------------------"
  echo "# Installing PlexWatchWeb"
  echo "#------------------------------------------------------------------------------"

  if [ ! -d $INST_PLEXWATCHWEB_PATH ] ; then
    printf "$PRINTF_MASK" $INST_PLEXWATCHWEB_PATH" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_PLEXWATCHWEB_PATH
    sudo chown `whoami`:staff $INST_PLEXWATCHWEB_PATH
  else
    printf "$PRINTF_MASK" $INST_PLEXWATCHWEB_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -d $INST_PLEXWATCHWEB_PATH/plexWatchWeb ] ; then
    printf "$PRINTF_MASK" "PlexWatchWeb doesn't exists, downloading respository..." "$YELLOW" "[WAIT]" "$RESET"
    cd $INST_PLEXWATCHWEB_PATH
    git clone https://github.com/ecleese/plexWatchWeb.git
    cd $DIR
  else
    printf "$PRINTF_MASK" "PlexWatchWeb exists" "$GREEN" "[OK]" "$RESET"
  fi

  if [ ! -d /Library/Server/Web/Data/Sites/Default ] ; then
    echo -e "${RED}-----------------------------------------------------------"
    echo -e "${RED}| ERROR"
    echo -e "${RED}-----------------------------------------------------------"
    echo -e "${RED}| OS X Server Webdirectory not found"
    echo -e "${RED}-----------------------------------------------------------"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
  else
    if [ -h /Library/Server/Web/Data/Sites/Default/plexWatchWeb ] ; then
      printf "$PRINTF_MASK" "Symbolic link to PlexWatchWeb exist" "$GREEN" "[OK]" "$RESET"
    else
      printf "$PRINTF_MASK" "Symbolic link to PlexWatchWeb doesn't exit, creating..." "$YELLOW" "[WAIT]" "$RESET"
      sudo ln -s $INST_PLEXWATCHWEB_PATH/plexWatchWeb /Library/Server/Web/Data/Sites/Default/plexWatchWeb
    fi
  fi
  echo "#------------------------------------------------------------------------------"
  echo "# Installing PlexWatchWeb - Complete"
  echo "#------------------------------------------------------------------------------"
fi
