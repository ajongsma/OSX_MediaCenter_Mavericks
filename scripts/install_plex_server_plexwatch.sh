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

if [[ -z $MYPLEX_UID ]] || [[ $MYPLEX_PW == "" ]]; then
  echo "-----------------------------------------------------------"
  echo "| Please provide the Plex username and password:"
  echo "| MYPLEX_UID : Username"
  echo "| MYPLEX_PW  : Password"
  echo "-----------------------------------------------------------"
  
  if [ ! -f config.sh ]; then
    open -a /Applications/TextWrangler.app ../config.sh
  else
    open -a /Applications/TextWrangler.app config.sh
  fi

  while ( [[ $MYPLEX_UID == "" ]] || [[ $MYPLEX_PW == "" ]] )
  do
    printf 'Waiting for the Plex information to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
    sleep 3
    source ../config.sh
  done
fi

printf "$PRINTF_MASK" "Modify Variables as needed" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$data_dir = '/Users/Plex/plexWatch';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$server_log = '"$HOME"/Library/Logs/Plex Media Server.log';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$log_client_ip = 1;" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = '"$MYPLEX_UID"';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "\$myPlex_user = '"$MYPLEX_PW"';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"

open -a /Applications/TextWrangler.app config.pl
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

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
