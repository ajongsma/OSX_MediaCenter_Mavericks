#!/usr/bin/env bash
source ../config.sh

function check_config() {
  echo "| username          : $INST_COUCHPOTATO_UID"
  echo "| password          : $INST_COUCHPOTATO_PW"
  echo "| port              : $INST_COUCHPOTATO_PORT"
}

if [ -e /Applications/CouchPotato.app ] ; then
  printf "$PRINTF_MASK" "-> SABnzbd is installed" "$GREEN" "[OK]" "$RESET"
  check_config
else
  printf "$PRINTF_MASK" "-> SABnzbd is not installed, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config
  
  if [ -d $INST_FOLDER_MOVIES_COMPLETE ] ; then
    printf "$PRINTF_MASK" $INST_FOLDER_MOVIES_COMPLETE" exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" $INST_FOLDER_MOVIES_COMPLETE" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p $INST_FOLDER_MOVIES_COMPLETE
  fi
  
  
  
  
  
fi

#### TESTING ####
exit 1
#### TESTING ####

echo "#------------------------------------------------------------------------------"
echo "# Installing CouchPotato"
echo "#------------------------------------------------------------------------------"
## http://christopher-williams.net/2011/02/automating-your-movie-downloads-with-sabnzbd-and-couchpotato/

echo "Download the latest CouchPotato from http://couchpotatoapp.com"
open http://couchpotatoapp.com
#open https://couchpota.to/updates/latest/osx/
#http://www.downloadbestsoft.com/download/CouchPotato-2.0.6.1.macosx-10_6-intel.zip

#cd ~/Downloads
printf 'Waiting for CouchPotato to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
while ( [ ! -e ~/Downloads/CouchPotato.app ] )
do
    printf '.'
    sleep 3
done
printf ".\n"
printf 'Download found, moving file…\n' "YELLOW" $col '[WAIT]' "$RESET"
sleep 5
sudo mv ~/Downloads/CouchPotato.app /Applications

open /Applications/CouchPotato.app

#osascript -e 'tell app "Terminal"
#    do script "open /Applications/CouchPotato.app"
#end tell'

#??
# python ~/Downloads/CouchPotato.app/CouchPotato.py -d
#??

echo "-----------------------------------------------------------"
echo "| Enter the following settings:"
echo "| "
echo "| Basics:"
echo "| username          : $INST_COUCHPOTATO_UID"
echo "| password          : $INST_COUCHPOTATO_PW"
echo "| port              : $INST_COUCHPOTATO_PORT"
echo "| Lauch Browser     : Uncheck"
echo "-----------------------------------------------------------"
echo "| Download Apps:"
echo "| "
echo "| Black Hole        : Disable"
echo "| SABNnzbd          : Enable"
echo "| SABnzbd URL       : localhost:$INST_SABNZBD_PORT"
echo "| SABnzbd API Key   : INST_SABNZBD_KEY_API=<paste value>"
echo "| SABnzbd Category  : movies"
echo "| Delete Failed     : Disable (Sabnzbd only)"
echo "-----------------------------------------------------------"
echo "| Registered at sites:"
echo "| "
echo "| Torrent related   : Disable all"
echo "-----------------------------------------------------------"
echo "| Move and rename the movies:"
echo "| "
echo "| => Enable: Show Advanced Settings"
echo "| "
echo "| Rename downloaded movies : Enable"
echo "| From              : $INST_FOLDER_USENET_COMPLETE"
echo "| To                : $INST_FOLDER_MOVIES_COMPLETE"
echo "| Cleanup           : Enable"
echo "| "
echo "| Run Every         : 1440 (e.g. 24 hours)"
echo "| Force Every       : 24 (e.g. 24 hours)"
echo "| Next On_failed    : Disable"

echo "| Download Subtitles: Enable"
echo "| Language          : nl"
echo "-----------------------------------------------------------"
echo "| Save settings"
echo "-----------------------------------------------------------"
echo ""
echo "-----------------------------------------------------------"
echo "| Settings (Click top-right gear icon)"
echo "-----------------------------------------------------------"
echo "| Searcher :"
echo "| Preferredd Words   : dutch"
echo "| Ignored Words      : <remove dutch>"
echo "| First search       : Usenet"
echo "| Retention          : $INST_NEWSSERVER_RETENTION"
echo "-----------------------------------------------------------"
#open http://localhost:5050/settings/
#open http://localhost:8082
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

source ../config.sh
if [[ -z $INST_COUCHPOTATOD_API ]] ; then
    echo "-----------------------------------------------------------"
    echo "| Main Site Settings, API:"
    echo "| Click Show Advanced settings"
    echo "| Add the CouchPotato API key to config.sh"
    echo "| INST_COUCHPOTATOD_API : <copy/paste the shown API KEY>"
    echo "-----------------------------------------------------------"
    open http://localhost:5050/settings/general
    subl ../config.sh

    while ( [[ $INST_COUCHPOTATOD_API == "" ]] )
    do
        printf 'Waiting for the CouchPotato API key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
        sleep 15
        source ../config.sh
    done
fi

INST_FILE_LAUNCHAGENT="com.couchpotato.couchpotato.plist"
if [ -f $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
  echo "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT"
  cp $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
  if [ "$?" != "0" ]; then
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | Copy failed: ${RESET}"
    echo -e "${RED} | $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    exit 1
  fi
else
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | LaunchAgent file not found: ${RESET}"
    echo -e "${RED} | $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
#    sudo mv /tmp/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
fi
launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT


echo "#------------------------------------------------------------------------------"
echo "# Install CouchPotato - Complete"
echo "#------------------------------------------------------------------------------"
