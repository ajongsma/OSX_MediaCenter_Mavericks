#!/usr/bin/env bash
source config.sh

## https://github.com/clinton-hall/nzbToMedia

function check_config_defaults() {
  if [[ -z $INST_NZBTOMEDIA_PATH ]] ; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| nzbToMedia Path             : INST_NZBTOMEDIA_PATH"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_NZBTOMEDIA_PATH == "" ]] )
    do
      printf '.\n'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

#if [ -d $INST_NZBTOMEDIA_PATH/nzbToMedia ] ; then
if [ ! -d $INST_NZBTOMEDIA_PATH/nzbToMedia ] ; then
  printf "$PRINTF_MASK" "nzbToMedia detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
else
  printf "$PRINTF_MASK" "nzbToMedia not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults
  
  if [ ! -d $INST_NZBTOMEDIA_PATH ] ; then
    printf "$PRINTF_MASK" $INST_NZBTOMEDIA_PATH" does't exists, creating" "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_NZBTOMEDIA_PATH
    sudo chown `whoami` $INST_NZBTOMEDIA_PATH
  else
    printf "$PRINTF_MASK" $INST_NZBTOMEDIA_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -d $INST_NZBTOMEDIA_PATH/nzbToMedia ] ; then
    printf "$PRINTF_MASK" "nzbToMedia not detected, downloading" "$YELLOW" "[WAIT]" "$RESET"

    cd $INST_NZBTOMEDIA_PATH
    git clone https://github.com/clinton-hall/nzbToMedia.git
  else
    printf "$PRINTF_MASK" "nzbToMedia detected" "$GREEN" "[OK]" "$RESET"
  fi


##cp -R ~/Github/nzbToMedia/* ~/Library/Application\ Support/SABnzbd/scripts/
#cp /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/

  if [ ! -h ~/Library/Application\ Support/SABnzbd/scripts/nzbToCouchPotato.py ]; then
    printf "$PRINTF_MASK" "Symbolic link nzbToCouchPotato.py not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
    sudo ln -sfv $INST_NZBTOMEDIA_PATH/nzbToMedia/nzbToCouchPotato.py ~/Library/Application\ Support/SABnzbd/scripts/nzbToCouchPotato.py
  else
    printf "$PRINTF_MASK" "Symbolic link nzbToCouchPotato.py detected" "$GREEN" "[OK]" "$RESET"
  fi
    
  if [ ! -f ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg ] ; then
    printf "$PRINTF_MASK" "autoProcessMedia.cfg not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
    
    cp $INST_NZBTOMEDIA_PATH/nzbToMedia/autoProcessMedia.cfg.sample ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
    echo "-----------------------------------------------------------"
    echo "| Modify the following:"
    echo "-----------------------------------------------------------"
    echo "| [CouchPotato]"
    echo "| apikey    =  $INST_COUCHPOTATO_KEY_API"
    echo "| port      =  $INST_COUCHPOTATO_PORT"
    echo "| "
    echo "| [SickBeard]"
    echo "| port      =  $INST_SICKBEARD_PORT"
    echo "| username  = $INST_SICKBEARD_UID"
    echo "| password  = $INST_SICKBEARD_PW"
    echo "-----------------------------------------------------------"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
    else
      open -a /Applications/TextWrangler.app ~/Library/Application\ Support/SABnzbd/scripts/autoProcessMedia.cfg
    fi
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
  else
    printf "$PRINTF_MASK" "autoProcessMedia.cfg detected" "$GREEN" "[OK]" "$RESET"
  fi





  
  cd $DIR
fi

##### TESTING #####
exit 0
##### TESTING #####

cd ~/Github/
git clone https://github.com/clinton-hall/nzbToMedia.git
cp -R ~/Github/nzbToMedia/* ~/Library/Application\ Support/SABnzbd/scripts/
#cp /Applications/Sick-Beard/autoProcessTV/* ~/Library/Application\ Support/SABnzbd/scripts/

cd ~/Library/Application\ Support/SABnzbd/scripts/
if [ ! -f autoProcessMedia.cfg ] ; then
    cp autoProcessMedia.cfg.sample autoProcessMedia.cfg
fi

#cp autoProcessTV.cfg.sample autoProcessTV.cfg
#cp autoProcessMovie.cfg.sample autoProcessMovie.cfg
#echo "-----------------------------------------------------------"
#echo "| Modify the following:"
#echo "| port=8081"
#echo "| username=couchpotato"
#echo "| password=<password>"
#echo "| web_root="
#echo "-----------------------------------------------------------"
#subl autoProcessTV.cfg

echo "#------------------------------------------------------------------------------"
echo "# Installing SABnzbd - nzbToMedia - Complete"
echo "#------------------------------------------------------------------------------"
