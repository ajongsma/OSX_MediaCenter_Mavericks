#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Trakt.TV for Plex"
echo "#------------------------------------------------------------------------------"
# https://forums.plex.tv/index.php/topic/102818-rel-trakt/

source config.sh

if [ ! -d $INST_TRAKT_PATH/Plex-Trakt-Scrobbler ] ; then
  if [ ! -d $INST_TRAKT_PATH ] ; then
    printf "$PRINTF_MASK" "TraktTV base path doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p $INST_TRAKT_PATH
  else
    printf "$PRINTF_MASK" "TraktTV base path exists" "$GREEN" "[OK]" "$RESET"
  fi
  printf "$PRINTF_MASK" "TraktTV doesn't exists, downloading respository..." "$YELLOW" "[WAIT]" "$RESET"
  cd $INST_TRAKT_PATH
  git clone https://github.com/trakt/Plex-Trakt-Scrobbler.git
else
  printf "$PRINTF_MASK" "TraktTV exists: "$INST_TRAKT_PATH"/Plex-Trakt-Scrobbler" "$GREEN" "[OK]" "$RESET"
fi

if [ ! -h ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Trakttv.bundle ] ; then
echo "1111"
else
echo "2222"
fi

if [ ! -d ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Trakttv.bundle ] ; then
echo "3333"
else
echo "4444"
fi


echo "Symbolic link doesn't exist, creating..." 
ln -s $INST_TRAKT_PATH/Plex-Trakt-Scrobbler/Trakttv.bundle/ ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/Trakttv.bundle

cd $DIR
if [[ -z $INST_TRAKT_KEY_API ]] || [[ $INST_TRAKT_PW == "" ]] || [[ $INST_TRAKT_KEY_API == "" ]]; then
  echo "-----------------------------------------------------------"
  echo "| Log on TraktTV "
  echo "| - Go to Settings, "
  echo "| - Select API"
  echo "| INST_TRAKT_KEY_UID : Username"
  echo "| INST_TRAKT_KEY_PW  : Password"
  echo "| INST_TRAKT_KEY_API : <copy/paste the shown API KEY>"
  echo "-----------------------------------------------------------"
  open http://trakt.tv/settings/api

  if [ ! -d /Applications/TextWrangler.app ]; then
    pico config.sh
  else
    open -a /Applications/TextWrangler.app config.sh
  fi

  while ( [[ $INST_TRAKT_UID == "" ]] || [[ $INST_TRAKT_PW == "" ]] || [[ $INST_TRAKT_KEY_API == "" ]] )
  printf 'Waiting for the Trakt information to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
  do
    printf '.' "YELLOW" $col '[WAIT]' "$RESET"
    sleep 5
    source config.sh
  done
fi

echo " -----------------------------------------------------------"
echo "| Installed  Trakttv.bundle to:"
echo "|   ~/Library/Application Support/Plex Media Server/Plug-ins"
echo "| "
echo "| Next steps:"
echo "| * Restart Plex Media Server (if needed)"
echo "| * Open the Plex/Web client."
echo "| * Navigate to Channels » Trakt.tv Scrobbler » Preferences"
echo "|   and enter your username and password"
echo "| *  Turn on scrobbling and any other settings you want to"
echo "| "
echo "| Set logging level in Plex Media Server"
echo "| In order for the scrobbler to detect what you are playing, you"
echo "| will need to set the logging level in the Plex Media Server (PMS)."
echo "| "
echo "| Go to Plex / Web (PMS icon in the menu bar, then select Media Manager (http://localhost:32400/web)"
echo "| Click on Settings (screwdriver / wrench logo)"
echo "| Click Show advanced settings"
echo "| Check the box for Plex Media Server verbose logging"
echo "| Click Save"
echo "| "
echo "| Now everything should be ready for you to start scrobbling your Movies and TV Shows to Trakt!"
echo " -----------------------------------------------------------"


#echo "-----------------------------------------------------------"
#echo "| [Trakt]"
#echo "| username                                : $INST_TRAKT_UID"
#echo "| password                                : $INST_TRAKT_PW"
#echo "|"
#echo "| [Optional]"
#echo "| plexlog_path                            : /var/log/PlexMediaServer.log"
#echo "-----------------------------------------------------------"
#subl config.ini

echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Install Trakt.TV for Plex - Complete"
echo "#------------------------------------------------------------------------------"
