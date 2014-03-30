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
cp config.pl-dist config.pl

printf "$PRINTF_MASK" "Modify Variables as needed" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "server = 'localhost';" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "port   = 32400;" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

pico config.pl


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
