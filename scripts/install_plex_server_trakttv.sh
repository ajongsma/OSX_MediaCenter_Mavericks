#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Installing Trakt.TV for Plex"
echo "#------------------------------------------------------------------------------"
# https://forums.plex.tv/index.php/topic/102818-rel-trakt/

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi


cd ~/Github

git clone https://github.com/trakt/Plex-Trakt-Scrobbler.git

ln -s Plex-Trakt-Scrobbler/Trakttv.bundle/ ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/

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
    subl ../config.sh

    while ( [[ $INST_TRAKT_UID == "" ]] || [[ $INST_TRAKT_PW == "" ]] || [[ $INST_TRAKT_KEY_API == "" ]] )
    do
      printf 'Waiting for the Trakt information to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
	    sleep 3
	    source ../config.sh
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

echo "#------------------------------------------------------------------------------"
echo "# Installing PlexWatch"
echo "#------------------------------------------------------------------------------"
##https://github.com/ljunkie/plexWatch

if [ ! -d $INST_PLEXWATCH_PATH ] ; then
    sudo mkdir -p $INST_PLEXWATCH_PATH
    sudo chown `whoami`:staff $INST_PLEXWATCH_PATH
fi
cd $INST_PLEXWATCH_PATH
git clone https://github.com/ljunkie/plexWatch.git
chmod 777 plexWatch
chmod 755 plexWatch/plexWatch.pl
cd plexWatch
if [ ! -f config.pl ] ; then
  printf "$PRINTF_MASK" "config.pl doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  cp config.pl-dist config.pl
else
  printf "$PRINTF_MASK" "config.pl exists" "$GREEN" "[OK]" "$RESET"
fi

printf "$PRINTF_MASK" "Modify Variables as needed" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$data_dir = '/Users/Plex/plexWatch';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$server_log = ".$HOME."'/Library/Logs/Plex Media Server.log';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$log_client_ip = 1;" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = '".$MYPLEX_UID."';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = '".$MYPLEX_PW."';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
pico config.pl

cp config/launchctl/com.plexserver.plexwatch.plist $HOME/Library/LaunchAgents


#if [ ! -e /Applications/iterm.app ] ; then
#  printf "$PRINTF_MASK" "iTerm not installed, please install..." "$RED" "[FAIL]" "$RESET"
#  open http://www.iterm2.com
#  while ( [ ! -e /Applications/iterm.app ] )
#  do
#    printf "$PRINTF_MASK" "Waiting for iTerm to be installed…" "$YELLOW" "[WAIT]" "$RESET"
#    sleep 15
#  done
#
#  open /Applications/iterm.app
#else
#  printf "$PRINTF_MASK" "iTerm 2 found" "$GREEN" "[OK]" "$RESET"
#fi

echo "#------------------------------------------------------------------------------"
echo "# Installing PlexWatch - Complete"
echo "#------------------------------------------------------------------------------"
