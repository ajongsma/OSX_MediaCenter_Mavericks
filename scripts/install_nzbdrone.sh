#!/usr/bin/env bash
source config.sh

## Download and install the Mono framework
## http://www.go-mono.com/mono-downloads/download.html
curl -O http://download.mono-project.com/archive/3.4.0/macos-10-x86/MonoFramework-MRE-3.4.0.macos10.xamarin.x86.pkg
open MonoFramework-MRE-3.4.0.macos10.xamarin.x86.pkg

## Download and install NzbDrone
curl -O http://update.nzbdrone.com/v2/master/osx/NzbDrone.master.osx.tar.gz
tar -xvzf NzbDrone.master.osx.tar.gz

mono --debug NzbDrone/NzbDrone.exe

open http://localhost:8989

echo "-------------"
echo "Advanced Settings: Enable"
echo "-------------"

echo "-------------"
echo "Settings -> Download Client"
echo "Add -> SABnzbd"
echo "Name:"
echo "Enable: Yes"
echo "Host:"
echo "Port: $INST_SABNZBD_PORT"
echo "API:  $INST_SABNZBD_API_KEY"
echo "UserName: $INST_SABNZBD_USERID"
echo "Password: $INST_SABNZBD_PW"
echo "Category: TV"
echo "-------------"
echo "Test -> Save"
echo "-------------"

echo "Drone Factory: $INST_FOLDER_USENET_COMPLETE"
echo "Drone Factory Interval: 5"
echo "-------------"
echo "Save"
echo "-------------"

echo "-------------"
echo "Settings -> Indexers"
echo "Add"
echo "Name: NZBPlanet"
echo "URL: http://nzbplanet.net"
echo "API: <http://nzbplanet.net/profile>"



##### TESTING #####
exit 1
##### TESTING #####


function check_config_defaults() {
  if [[ -z $INST_COUCHPOTATO_UID ]] || [[ -z $INST_COUCHPOTATO_PW ]] || [[ -z $INST_COUCHPOTATO_PORT ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| username          : $INST_COUCHPOTATO_UID"
    echo "| password          : $INST_COUCHPOTATO_PW"
    echo "| port              : $INST_COUCHPOTATO_PORT"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_COUCHPOTATO_UID == "" ]] || [[ $INST_COUCHPOTATO_PW == "" ]] || [[ $INST_COUCHPOTATO_PORT == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

function check_config_var() {
  if [[ -z $INST_COUCHPOTATO_KEY_API ]] ; then
    printf 'CouchPotato API key was not detected in config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| API               : $INST_COUCHPOTATO_KEY_API "
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_COUCHPOTATO_KEY_API == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}


if [ -e /Applications/CouchPotato.app ] ; then
  printf "$PRINTF_MASK" "-> CouchPotato detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
  check_config_var
else
  printf "$PRINTF_MASK" "-> CouchPotato not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults
  
  if [ -d $INST_FOLDER_MOVIES_COMPLETE ] ; then
    printf "$PRINTF_MASK" $INST_FOLDER_MOVIES_COMPLETE" exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" $INST_FOLDER_MOVIES_COMPLETE" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p $INST_FOLDER_MOVIES_COMPLETE
  fi
  
  printf "$PRINTF_MASK" "Download the latest CouchPotato from http://couchpotatoapp.com" "$YELLOW" "[WAIT]" "$RESET"
  open http://couchpotatoapp.com
  
  printf 'Waiting for CouchPotato to be downloaded…\n' "YELLOW" $col '[WAIT]' "$RESET"
  while ( [ ! -e ~/Downloads/CouchPotato.app ] )
  do
      printf '.'
      sleep 3
  done
  printf ".\n"
  
  printf 'Download found, moving file…\n' "YELLOW" $col '[WAIT]' "$RESET"
  #sleep 2
  sudo mv ~/Downloads/CouchPotato.app /Applications
  #sleep 1
  xattr -d com.apple.quarantine /Applications/CouchPotato.app
  open /Applications/CouchPotato.app

  echo "-----------------------------------------------------------"
  echo "| Enter the following settings:"
  echo "| "
  echo "| Basics:"
  echo "| username          : $INST_COUCHPOTATO_UID"
  echo "| password          : $INST_COUCHPOTATO_PW"
  echo "| port              : $INST_COUCHPOTATO_PORT"
  echo "| Lauch Browser     : Uncheck"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "| Download Apps:"
  echo "| "
  echo "| Black Hole        : Disable"
  
  if [[ $INST_SABNZBD == "true" ]]; then
    echo "| SABNnzbd          : Enable"
    echo "| SABnzbd URL       : localhost:$INST_SABNZBD_PORT"
    echo "| SABnzbd API Key   : $INST_SABNZBD_KEY_API"
    echo "| SABnzbd Category  : movies"
    echo "| Delete Failed     : Disable (Sabnzbd only)"
  fi
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "-----------------------------------------------------------"
  echo "| Registered at sites:"
  echo "| "
  echo "| Torrent Providers   : Disable all"
  echo "| Usenet Providers    : Enable Nzbindex"
  echo "| Usenet Providers    : Disable Newznab"
  echo "| Usenet Providers    : Enable Nzbclub"
  echo "| Usenet Providers    : Enable Binsearch"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "| Move and rename the movies:"
  echo "| "
  echo "| Rename downloaded movies : Enable"
  echo "| From              : $INST_FOLDER_USENET_COMPLETE"
  echo "| To                : $INST_FOLDER_MOVIES_COMPLETE"
  echo "| Cleanup           : Enable"
  echo "-----------------------------------------------------------"
  echo "| Click Finish Up"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "-----------------------------------------------------------"
  echo "| Login to CouchPotato"
  echo "| username          : $INST_COUCHPOTATO_UID"
  echo "| password          : $INST_COUCHPOTATO_PW"
  echo "-----------------------------------------------------------"
  echo ""
  echo "-----------------------------------------------------------"
  echo "| Settings (Click top-right gear icon)"
  echo "-----------------------------------------------------------"
  echo "| Searcher"
  echo "|   First search    : Usenet"
  echo "|   Retention       : $INST_NEWSSERVER_RETENTION"
  echo "|"
  echo "| Searcher, Categories"
  echo "|   Preferredd Words: dutch, nl subs, nlsubs"
  echo "|   Ignored Words   : <remove dutch>"
  echo "-----------------------------------------------------------"
  #open http://localhost:5050/settings/
  #open http://localhost:8082
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Renamer"
  echo "|   Advanced Settings: Enable"
  echo "|   Run Every       : 1440 (e.g. 24 hours)"
  echo "|   Force Every     : 24 (e.g. 24 hours)"
  echo "|"
  echo "| Download Subtitles: Enable"
  echo "| Language          : nl"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  source config.sh
  if [[ -z $INST_COUCHPOTATO_KEY_API ]] ; then
    echo "-----------------------------------------------------------"
    echo "| Main Site Settings, API:"
    echo "| Click Show Advanced settings"
    echo "| Add the CouchPotato API key to config.sh"
    echo "| INST_COUCHPOTATOD_API : <copy/paste the shown API KEY>"
    echo "-----------------------------------------------------------"
    open http://localhost:5050/settings/general
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    
    printf 'Waiting for the CouchPotato API key to be added to config.sh...\n' "$YELLOW" $col '[WAIT]' "$RESET"
    while ( [[ $INST_COUCHPOTATO_KEY_API == "" ]] )
    do
        printf '.'
        sleep 15
        source config.sh
    done
    printf '.\n' "$GREEN" $col '[OK]' "$RESET"
  fi
  
  INST_FILE_LAUNCHAGENT="com.couchpotato.couchpotato.plist"
  if [ ! -f ~/Library/LaunchAgents/ ] ; then
    printf 'LaunchAgent not found, installing...\n' "$YELLOW" $col '[WAIT]' "$RESET"
  
    if [ -f $DIR/config/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
      printf 'Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT' "$YELLOW" $col '[WAIT]' "$RESET"
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
    fi
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
  else
    printf 'LaunchAgent found' "$GREEN" $col '[OK]' "$RESET"
  fi
  printf "$PRINTF_MASK" "-> CouchPotato installed" "$GREEN" "[OK]" "$RESET"
fi

## http://christopher-williams.net/2011/02/automating-your-movie-downloads-with-sabnzbd-and-couchpotato/
#open https://couchpota.to/updates/latest/osx/
#http://www.downloadbestsoft.com/download/CouchPotato-2.0.6.1.macosx-10_6-intel.zip

#cd ~/Downloads
#osascript -e 'tell app "Terminal"
#    do script "open /Applications/CouchPotato.app"
#end tell'

#??
# python ~/Downloads/CouchPotato.app/CouchPotato.py -d
#??
