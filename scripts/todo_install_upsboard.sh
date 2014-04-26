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

if [ ! -e /usr/local/bin/npm ] ; then
  printf "$PRINTF_MASK" "NPM not detected" "$RED" "[ERR]" "$RESET"
  echo " --- press any key to continue ---"
  read -n 1 -s
  exit 1
else
  printf "$PRINTF_MASK" "NPM detected, installing required modules..." "$YELLOW" "[WAIT]" "$RESET"
  npm install express
  npm install stylus
  npm install nib
  npm install when
  npm install bcrypt
  npm install express-uglify
  npm install passport
  npm install passport-local
  npm install underscore
  npm install moment
  npm install request
  npm install xml2js
  npm install ssh2
  npm install gm
  npm install body-parser
  npm install cookie-parser
  npm install csurf
  npm install errorhandler
  npm install method-override
  npm install morgan
  npm install response-time
  npm install cookie-session
  npm install serve-static
  npm install static-favicon
  
  #npm list -g --depth=1 | awk -F ' ' '{print $2}' | awk -F '@' '{print $1}'  | xargs npm remove -g
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

