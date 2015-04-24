#!/usr/bin/env bash
source config.sh

echo "#------------------------------------------------------------------------------"
echo "# Installing PlexEmail"
echo "#------------------------------------------------------------------------------"
##https://github.com/jakewaldron/PlexEmail
##https://github.com/jakewaldron/PlexEmail.git

if [ ! -d $INST_PLEXMAIL_PATH ] ; then
  printf "$PRINTF_MASK" $INST_PLEXMAIL_PATH" doesn't exists, copying..." "$YELLOW" "[WAIT]" "$RESET"
  sudo mkdir -p $INST_PLEXMAIL_PATH
  sudo chown `whoami`:staff $INST_PLEXMAIL_PATH
else
  printf "$PRINTF_MASK" $INST_PLEXMAIL_PATH" exists" "$GREEN" "[OK]" "$RESET"
fi
cd $INST_PLEXEMAIL_PATH

if [ ! -d $INST_PLEXEMAIL_PATH/PlexEmail ] ; then
  printf "$PRINTF_MASK" "PlexEmail doesn't exists, downloading respository..." "$YELLOW" "[WAIT]" "$RESET"
  git clone https://github.com/jakewaldron/PlexEmail.git
  
  sudo chown `whoami`:staff $INST_PLEXEMAIL_PATH/PlexEmail
else
  printf "$PRINTF_MASK" "PlexEmail exists" "$GREEN" "[OK]" "$RESET"
fi

cd $INST_PLEXEMAIL_PATH/PlexEmail/scripts

printf "$PRINTF_MASK" "Modify Variables as needed" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "plex_data_folder = <Plex Username>';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "plex_username    = <Plex Username>';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "plex_password    = <Plex Password>';" "$GREY" "|" "$RESET"

printf "$PRINTF_MASK" "email_username   = <GMail Username>';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "email_password   = <GMail Password>';" "$GREY" "|" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$GREY" "|" "$RESET"


#open -a /Applications/TextWrangler.app config.pl
if [ ! -d /Applications/TextWrangler.app ]; then
  pico $INST_PLEXEMAIL_PATH/PlexEmail/scripts/config.conf
else
  open -a /Applications/TextWrangler.app $INST_PLEXEMAIL_PATH/PlexEmail/scripts/config.conf
fi
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

####sudo ln -s /Users/Plex/PlexEmail/web /Library/Server/Web/Data/Sites/Default/PlexEmail
##sudo ln -s $INST_PLEXEMAIL_PATH/PlexEmail/web /Library/Server/Web/Data/Sites/Default/PlexEmail

pip install requests

python plexEmail.py -t





cd $DIR
echo "#------------------------------------------------------------------------------"
echo "# Installing PlexEmail - Complete"
echo "#------------------------------------------------------------------------------"
