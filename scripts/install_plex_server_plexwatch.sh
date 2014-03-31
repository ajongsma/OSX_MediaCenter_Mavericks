#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing PlexWatch"
echo "#------------------------------------------------------------------------------"
##https://github.com/ljunkie/plexWatch

if [ ! -d $INST_PLEXWATCH_PATH ] ; then
  printf "$PRINTF_MASK" $INST_PLEXWATCH_PATH" doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  sudo mkdir -p $INST_PLEXWATCH_PATH
  sudo chown `whoami`:staff $INST_PLEXWATCH_PATH
else
  printf "$PRINTF_MASK" $INST_PLEXWATCH_PATH" exists" "$GREEN" "[OK]" "$RESET"
fi
cd $INST_PLEXWATCH_PATH

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

printf "$PRINTF_MASK" "Modify Variables as needed" "$GREEN" "|" "$RESET"
printf "$PRINTF_MASK" "\$data_dir = '/Users/Plex/plexWatch';" "$GREEN" "|" "$RESET"
printf "$PRINTF_MASK" "\$server_log = '"$HOME"/Library/Logs/Plex Media Server.log';" "$GREEN" "|" "$RESET"
printf "$PRINTF_MASK" "\$log_client_ip = 1;" "$GREEN" "|" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = <Plex Username>';" "$GREEN" "|" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = <Plex Password>';" "$GREEN" "|" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$GREEN" "|" "$RESET"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
open -a /Applications/TextWrangler.app config.pl

if [ ! -f $HOME/Library/LaunchAgents/com.plexserver.plexwatch.plist ] ; then
  printf "$PRINTF_MASK" "com.plexserver.plexwatch.plist doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  cp ./config/launchctl/com.plexserver.plexwatch.plist $HOME/Library/LaunchAgents
else
  printf "$PRINTF_MASK" "com.plexserver.plexwatch.plist exists" "$GREEN" "[OK]" "$RESET"
fi

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
