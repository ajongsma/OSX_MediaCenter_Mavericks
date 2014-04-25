#!/usr/bin/env bash
source config.sh

## https://forums.plex.tv/index.php/topic/93731-upsboard-usenet-plex-stats/

if [ ! -e /usr/local/bin/node ] ; then
  printf "$PRINTF_MASK" "Node not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  if [ ! -e /usr/local/bin/brew ] ; then
    printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
    echo " --- press any key to continue ---"
    read -n 1 -s
    exit 1
  else
    brew install node
  fi
else
  printf "$PRINTF_MASK" "Node detected" "$GREEN" "[OK]" "$RESET"
fi

sudo mkdir /Users/Upsboard
sudo chown `whoami` /Users/Upsboard
cd /Users/Upsboard

git clone https://github.com/lienma/UpsBoard.git

cd UpsBoard
cp config.js-sample config.js
nano config.js

## Starting it all up
node app

