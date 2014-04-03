#!/usr/bin/env bash

source config.sh

if [ -e /Applications/SABnzbd.app ] ; then
  if [[ -z $INST_SABNZBD_KEY_API ]] || [[ -z $INST_SABNZBD_KEY_NZB ]]; then
    echo "-----------------------------------------------------------"
    echo "| SABnzbd Web Server:"
    echo "| Please add the SABnzbd Web Server API key and NZB key to config.sh"
    echo "| API Key                              : INST_SABNZBD_KEY_API=<paste value> "
    echo "| NZB Key                              : INST_SABNZBD_KEY_NZB=<paste value>"
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    open http://localhost:8080/config/general/
    
    printf 'Waiting for SabNZBD API and NZB key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]])
    do
      printf '.'
      sleep 2
      source config.sh
    done
  fi
  
  printf "$PRINTF_MASK" "-> SABnzbd is installed" "$GREEN" "[OK]" "$RESET"
else
  echo "#------------------------------------------------------------------------------"
  echo "# Install SabNZBD"
  echo "#------------------------------------------------------------------------------"
  
  if [ -d $INST_FOLDER_USENET_WATCH ] ; then
    printf "$PRINTF_MASK" $INST_FOLDER_USENET_WATCH" exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" $INST_FOLDER_USENET_WATCH" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p $INST_FOLDER_USENET_WATCH
  fi
  
  if [ -d $INST_FOLDER_USENET_INCOMPLETE ] ; then
    printf "$PRINTF_MASK" $INST_FOLDER_USENET_INCOMPLETE" exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" $INST_FOLDER_USENET_INCOMPLETE" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p $INST_FOLDER_USENET_INCOMPLETE
  fi
  
  if [ -d $INST_FOLDER_USENET_INCOMPLETE ] ; then
    printf "$PRINTF_MASK" $INST_FOLDER_USENET_COMPLETE" exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" $INST_FOLDER_USENET_COMPLETE" doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir -p $INST_FOLDER_USENET_COMPLETE
  fi
  if [ -d ~/Library/Application\ Support/scripts ] ; then
    printf "$PRINTF_MASK" "~/Library/Application\ Support/scripts exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "~/Library/Application\ Support/scripts doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
    mkdir ~/Library/Application\ Support/scripts
  fi
  
  if [[ -z $INST_NEWSSERVER_SERVER ]] || [[ -z $INST_NEWSSERVER_SERVER_PORT_SSL ]] || [[ -z $INST_NEWSSERVER_SERVER_UID ]] || [[ -z $INST_NEWSSERVER_SERVER_PW ]] || [[ -z $INST_SABNZBD_UID ]] || [[ -z $INST_SABNZBD_PW ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "-----------------------------------------------------------"
    echo "| News Server:"
    echo "| Server                                  : \$INST_NEWSSERVER_SERVER"
    echo "| Port                                    : \$INST_NEWSSERVER_SERVER_PORT_SSL"
    echo "| User Name                               : \$INST_NEWSSERVER_SERVER_UID"
    echo "| Password                                : \$INST_NEWSSERVER_SERVER_PW"
    echo "| SABnzbd:"
    echo "| SABnzbd User Name                       : \$INST_SABNZBD_UID"
    echo "| SABnzbd Password                        : \$INST_SABNZBD_PW"
    echo "-----------------------------------------------------------"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    while ( [[ $INST_NEWSSERVER_SERVER == "" ]] || [[ $INST_NEWSSERVER_SERVER_PORT_SSL == "" ]] || [[ $INST_NEWSSERVER_SERVER_UID == "" ]] || [[ $INST_NEWSSERVER_SERVER_PW == "" ]] || [[ $INST_SABNZBD_UID == "" ]] || [[ $INST_SABNZBD_PW == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "Value for INST_SABNZBD_KEY_API found" "$GREEN" "[OK]" "$RESET"
    printf "$PRINTF_MASK" "Value for INST_SABNZBD_KEY_NZB found" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -d /Applications/TextWrangler.app ]; then
    printf "$PRINTF_MASK" "SABnzbd is not installed, please install..." "$YELLOW" "[WAIT]" "$RESET"
    open http://sabnzbd.org/
    while ( [ ! -e /Applications/SABnzbd.app ] )
    do
      printf "."
      sleep 2
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "SABnzbd intall detected" "$GREEN" "[OK]" "$RESET"
  fi
  
  xattr -d com.apple.quarantine /Applications/SABnzbd.app
  
  echo "-----------------------------------------------------------"
  echo "| News Server Setup:"
  echo "| Server                                  : $INST_NEWSSERVER_SERVER"
  echo "| Port                                    : $INST_NEWSSERVER_SERVER_PORT_SSL"
  echo "| User Name                               : $INST_NEWSSERVER_SERVER_UID"
  echo "| Password                                : $INST_NEWSSERVER_SERVER_PW"
  echo "| SSL                                     : Enable"
  echo "-----------------------------------------------------------"
  echo "| Step 2"
  echo "| Access                                  : I want SABnzbd to be viewable by any pc on my network."
  echo "| Password protect access to SABnzbd      : Enable"
  echo "| User Name                               : $INST_SABNZBD_UID"
  echo "| Password                                : $INST_SABNZBD_PW"
  echo "| HTTPS                                   : Disable"
  echo "| Launch                                  : Disable"
  echo "-----------------------------------------------------------"
  open /Applications/SABnzbd.app 
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Folders:"
  echo "| Temporary Download Folder               : $INST_FOLDER_USENET_INCOMPLETE"
  echo "| Minimum Free Space                      : 1G"
  echo "| Completed Download Folder               : $INST_FOLDER_USENET_COMPLETE"
  echo "| Watched Folder                          : $INST_FOLDER_USENET_WATCH"
  echo "| Watched Folder Scan Speed               : 300"
  echo "| Post Processing Folder                  : ~/Library/Application Support/SABnzbd/scripts"
  echo "-----------------------------------------------------------"
  http://localhost:8080/sabnzbd/config/
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Switches"
  echo "| Queue:"
  echo "| Abort jobs that cannot be completed     : Enable"
  echo "| Check before download                   : Enable"
  echo "| Pause Downloading durig post-processing : Enable"
  echo "|"
  echo "| Post processing:"
  echo "| Ignore Samples                          : Delete"
  echo "| Post-Process Only Verified Jobs         : Disable"
  echo "|"
  echo "| Special:"
  echo "| Empty_postproc                          : Enable"
  echo "-----------------------------------------------------------"
  open http://localhost:8080/config/switches/
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "-----------------------------------------------------------"
  echo "| Create the following categories:"
  echo "| anime, Default, Default, Default"
  echo "| apps, Default, Default, Default"
  echo "| books, Default, Default, Default"
  echo "| consoles, Default, Default, Default"
  echo "| games, Default, Default, Default"
  echo "| movies, Default, Default, Default"
  echo "| music, Default, Default, Default"
  echo "| pda, Default, Default, Default"
  echo "| tv, Default, Default, Default"
  echo "-----------------------------------------------------------"
  open http://localhost:8080/sabnzbd/config/categories/
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  source config.sh
  #if [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]]; then
  if [[ -z $INST_SABNZBD_KEY_API ]] || [[ -z $INST_SABNZBD_KEY_NZB ]]; then
    echo "-----------------------------------------------------------"
    echo "| SABnzbd Web Server:"
    echo "| Please add the SABnzbd Web Server API key and NZB key to config.sh"
    echo "| API Key                              : INST_SABNZBD_KEY_API=<paste value> "
    echo "| NZB Key                              : INST_SABNZBD_KEY_NZB=<paste value>"
    echo "-----------------------------------------------------------"
    #open http://localhost/newznab/admin/site-edit.php
    open http://localhost:8080/config/general/
    
    printf 'Waiting for SabNZBD API and NZB key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_SABNZBD_KEY_API == "" ]] || [[ $INST_SABNZBD_KEY_NZB == "" ]])
    do
      printf '.' "YELLOW" $col '[WAIT]' "$RESET"
      sleep 2
      source config.sh
    done
  fi

  INST_FILE_LAUNCHAGENT="com.sabnzbd.SABnzbd.plist"
  if [ -f ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT ] ; then
    printf "$PRINTF_MASK" "LaunchAgents $INST_FILE_LAUNCHAGENT exist" "$GREEN" "[OK]" "$RESET"
  else
    if [ -f $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT ] ; then
      echo "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT"
      cp $DIR/launchctl/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
      if [ "$?" != "0" ]; then
        echo -e "${RED}  ============================================== ${RESET}"
        echo -e "${RED} | ERROR ${RESET}"
        echo -e "${RED} | Copy failed: ${RESET}"
        echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
        echo -e "${RED} | --- press any key to continue --- ${RESET}"
        echo -e "${RED}  ============================================== ${RESET}"
        read -n 1 -s
        exit 1
      fi
    else
      echo -e "${RED}  ============================================== ${RESET}"
      echo -e "${RED} | ERROR ${RESET}"
      echo -e "${RED} | LaunchAgent file not found: ${RESET}"
      echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
      echo -e "${RED} | --- press any key to continue --- ${RESET}"
      echo -e "${RED}  ============================================== ${RESET}"
      read -n 1 -s
      sudo mv /tmp/$INST_FILE_LAUNCHAGENT ~/Library/LaunchAgents/
    fi
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
  fi

  echo "#------------------------------------------------------------------------------"
  echo "# Installation SabNZBD Complete"
  echo "#------------------------------------------------------------------------------"
fi

#echo "-----------------------------------------------------------"
#echo "| Add SabNZBD support to NewzNAB:"
#echo "|*Integration Type              : User"
#echo "| SABnzbd Url                   : http://localhost:8080/sabnzbd/"
#echo "| SABnzbd Api Key               : $INST_SABNZBD_KEY_API"
#echo "| Api Key Type (full)           : Full"
#echo "-----------------------------------------------------------"
#open http://localhost/newznab/admin/site-edit.php
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

#  if [[ -z $INST_SABNZBD_KEY_API ]] || [[ -z $INST_SABNZBD_KEY_NZB ]]; then
#    echo "-----------------------------------------------------------"
#    echo "| SABnzbd Web Server:"
#    echo "| Please add the SABnzbd Web Server API key and NZB key to config.sh"
#    echo "| API Key                              : INST_SABNZBD_KEY_API=<paste value> "
#    echo "| NZB Key                              : INST_SABNZBD_KEY_NZB=<paste value>"
#    echo "-----------------------------------------------------------"
#    #open http://localhost/newznab/admin/site-edit.php
#    open http://localhost:8080/config/general/
#    
#    printf 'Waiting for SabNZBD API and NZB key to be added to config.sh...\n' "YELLOW" $col '[WAIT]' "$RESET"
#    if [ ! -d /Applications/TextWrangler.app ]; then
#      pico config.sh
#    else
#      open -a /Applications/TextWrangler.app config.sh
#    fi
#  else
#    printf "$PRINTF_MASK" "Value for INST_SABNZBD_KEY_API found" "$GREEN" "[OK]" "$RESET"
#    printf "$PRINTF_MASK" "Value for INST_SABNZBD_KEY_NZB found" "$GREEN" "[OK]" "$RESET"
#  fi
