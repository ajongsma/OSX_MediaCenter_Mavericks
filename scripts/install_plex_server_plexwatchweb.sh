#!/usr/bin/env bash

#if [ ! -f config.sh ]; then
#  source ../config.sh
#else
#  source config.sh
#fi
source ../config.sh
#https://github.com/ecleese/plexWatchWeb.git

if [ ! -f $INST_PLEXWATCH_PATH/plexWatchWeb/index.php ] ; then
  echo "#------------------------------------------------------------------------------"
  echo "# Installing PlexWatch/Web"
  echo "#------------------------------------------------------------------------------"
else

fi

if [ ! -d $INST_PLEXWATCHWEB_PATH ] ; then
  printf "$PRINTF_MASK" $INST_PLEXWATCHWEB_PATH" doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  sudo mkdir -p $INST_PLEXWATCHWEB_PATH
  sudo chown `whoami`:staff $INST_PLEXWATCHWEB_PATH
else
  printf "$PRINTF_MASK" $INST_PLEXWATCH_PATH" exists" "$GREEN" "[OK]" "$RESET"
fi
cd $INST_PLEXWATCHWEB_PATH



##################### TESTING #####################

if [ ! -d $INST_PLEXWATCH_PATH/plexwatch ] ; then
  printf "$PRINTF_MASK" "PlexWatch doesn't exists, downloading respository..." "$YELLOW" "[WAIT]" "$RESET"
  git clone https://github.com/ljunkie/plexWatch.git
  chmod 777 plexWatch
  chmod 755 plexWatch/plexWatch.pl
else
  printf "$PRINTF_MASK" "PlexWatch exists" "$GREEN" "[OK]" "$RESET"
fi

cd plexWatch
if [ ! -f config.pl ] ; then
  printf "$PRINTF_MASK" "PlexWatch config.pl doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  cp config.pl-dist config.pl
else
  printf "$PRINTF_MASK" "config.pl exists" "$GREEN" "[OK]" "$RESET"
fi

printf "$PRINTF_MASK" "Modify Variables as needed" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "\$data_dir = '/Users/Plex/plexWatch';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "\$server_log = '"$HOME"/Library/Logs/Plex Media Server.log';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "\$log_client_ip = 1;" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = <Plex Username>';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = <Plex Password>';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$GREY" "|" "$RESET"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
open -a /Applications/TextWrangler.app config.pl

if [ ! -f $HOME/Library/LaunchAgents/com.plexserver.plexwatch.plist ] ; then
  printf "$PRINTF_MASK" "com.plexserver.plexwatch.plist doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  cp ./config/launchctl/com.plexserver.plexwatch.plist $HOME/Library/LaunchAgents
  launchctl load ~/Library/LaunchAgents/com.plexserver.plexwatch.plist
else
  printf "$PRINTF_MASK" "com.plexserver.plexwatch.plist exists" "$GREEN" "[OK]" "$RESET"
fi

cd $DIR
echo "#------------------------------------------------------------------------------"
echo "# Installing PlexWatch - Complete"
echo "#------------------------------------------------------------------------------"
