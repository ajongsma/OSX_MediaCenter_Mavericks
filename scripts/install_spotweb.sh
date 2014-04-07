#!/usr/bin/env bash
source config.sh

## http://gathering.tweakers.net/forum/list_messages/1478602

# INST_SPOTWEB_PSQL_DB="spotweb_db"
# INST_SPOTWEB_PSQL_UID="spotweb_usr"
# INST_SPOTWEB_PSQL_PW="mini"

#
# INST_APACHE_SYSTEM_WEB_ROOT="/Library/Server/Web/Data/Sites/Default"

function check_config_defaults() {
  if [[ -z $INST_SPOTWEB_UID ]] || [[ -z $INST_SPOTWEB_PW ]] || [[ -z $INST_SPOTWEB_PATH ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| Spotweb Username            : $INST_SPOTWEB_UID"
    echo "| Spotweb Password            : $INST_SPOTWEB_PW"
    echo "| Spotweb Path                : $INST_SPOTWEB_PATH"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_SPOTWEB_UID == "" ]] || [[ $INST_SPOTWEB_PW == "" ]] || [[ $INST_SPOTWEB_PATH == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

function check_config_var() {
  if [[ -z $INST_SPOTWEB_KEY_API_SICKBEARD ]] || [[ -z $INST_SPOTWEB_KEY_API_COUCHPOTATO ]] ; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| Spotweb Sickbeard API Key   : $INST_SPOTWEB_KEY_API_SICKBEARD"
    echo "| Spotweb CouchPotati API Key : $INST_SPOTWEB_KEY_API_COUCHPOTATO"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_SPOTWEB_KEY_API_SICKBEARD == "" ]] || [[ $INST_SPOTWEB_KEY_API_COUCHPOTATO == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}

if [ -h $INST_APACHE_SYSTEM_WEB_ROOT/spotweb ] ; then
  printf "$PRINTF_MASK" "-> Spotweb detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
  check_config_var
else
  printf "$PRINTF_MASK" "-> Spotweb not detected, installing..." "$GREEN" "[OK]" "$RESET"
  check_config_defaults

  if [ ! -d $INST_SPOTWEB_PATH ] ; then
    printf "$PRINTF_MASK" $INST_SPOTWEB_PATH" does't exists, creating" "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_SPOTWEB_PATH
    sudo chown `whoami` $INST_SPOTWEB_PATH
  else
    printf "$PRINTF_MASK" $INST_SPOTWEB_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi
  
  cd $INST_SPOTWEB_PATH
  if [ ! -d $INST_SPOTWEB_PATH/spotweb ] ; then
    printf "$PRINTF_MASK" $INST_SPOTWEB_PATH"/spotweb does't exists, downloading..." "$YELLOW" "[WAIT]" "$RESET"
    git clone https://github.com/spotweb/spotweb.git
  else
    printf "$PRINTF_MASK" $INST_SPOTWEB_PATH"/spotweb exists, updating..." "$YELLOW" "[WAIT]" "$RESET"
    git pull https://github.com/spotweb/spotweb.git
  fi

  if [ ! -h $INST_APACHE_SYSTEM_WEB_ROOT/spotweb ] ; then
    printf "$PRINTF_MASK" "Symbolic link not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
    ln -s $INST_SPOTWEB_PATH/Sites/spotweb /Library/Server/Web/Data/Sites/Default/spotweb
  else
    printf "$PRINTF_MASK" "Symbolic link detected" "$GREEN" "[OK]" "$RESET"
  fi

open http://localhost/spotweb


  cd $DIR
fi

##### TESTING #####
exit 1
##### TESTING #####

#------------------------------------------------------------------------------
# Install Spotweb
#------------------------------------------------------------------------------
#export PATH=$PATH:/usr/local/opt/postgresql/bin

#sudo -u andries psql postgres -c "create database spotweb_db"
#sudo -u andries psql postgres -c "create user spotweb_user with password 'spotweb_user'"
#sudo -u andries psql postgres -c "grant all privileges on database spotweb_db to spotweb_user"

sudo -u andries psql postgres -c "create database $INST_NEWZNAB_PSQL_DB"
sudo -u andries psql postgres -c "create user $INST_NEWZNAB_PSQL_UID with password '"$INST_NEWZNAB_PSQL_PW"'"
sudo -u andries psql postgres -c "grant all privileges on database $INST_NEWZNAB_PSQL_DB to $INST_NEWZNAB_PSQL_UID"

### ERROR:  syntax error at or near "'mini_spotweb'"
### sudo -u andries psql -c ALTER USER spotweb_usr SET PASSWORD 'mini_spotweb';
sudo -u andries psql -c "ALTER USER $INST_NEWZNAB_PSQL_UID SET PASSWORD '"$INST_NEWZNAB_PSQL_PW"';"

#?? open /Applications/pgAdmin3.app
#?? echo "Open pgAdmin and set the password of user: spotweb_user"

#cd /Library/WebServer/Documents/
#sudo git clone https://github.com/spotweb/spotweb.git
#subl /Library/WebServer/Documents/spotweb/dbsettings.inc.php

#echo "----------------------------------------------------------"
#echo "| Add an alias and enable htaccess for NewzNAB to the default website:"
#echo "| Create alias in Server Website"
#echo "|   Path                        : /spotweb"
#echo "|   Folder                      : $INST_SPOTWEB_PATH"
#echo "| Enable overrides using .htaccess files"
#echo "-----------------------------------------------------------"
#open /Applications/Server.app
#echo " --- press any key to continue ---"
#read -n 1 -s





sudo ln -s $INST_SPOTWEB_PATH/Sites/spotweb /Library/Server/Web/Data/Sites/Default/spotweb
#sudo ln -s /Users/Spotweb/Sites/spotweb/ /Library/WebServer/Documents/spotweb

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Type                          : PostgreSQL"
echo "| Server                        : localhost"
echo "| Database                      : $INST_NEWZNAB_PSQL_DB"
echo "| Username                      : $INST_NEWZNAB_PSQL_UID"
echo "| Password                      : $INST_NEWZNAB_PSQL_PW"
echo "-----------------------------------------------------------"
echo "| Usenet Server                 : $INST_NEWSSERVER_NAME"
echo "| User Name                     : $INST_NEWSSERVER_SERVER_UID"
echo "-----------------------------------------------------------"
open http://localhost/spotweb/install.php
echo " --- press any key to continue ---"
read -n 1 -s

echo "-----------------------------------------------------------"
echo "| After finishing all steps, copy/paste the information as during the last phase"
sudo touch $INST_SPOTWEB_PATH/dbsettings.inc.php
sudo subl $INST_SPOTWEB_PATH/dbsettings.inc.php
echo " --- press any key to continue ---"
read -n 1 -s

#/Library/WebServer/Documents/spotweb/retrieve.php
#sh php /Library/WebServer/Documents/spotweb/retrieve.php
#/bin/bash php /Library/WebServer/Documents/spotweb/retrieve.php

echo "-----------------------------------------------------------"
echo "| Click on the Cogwheel top-right and enter the following settings:"
echo "| "
echo "| NZB Handeling"
echo "| What shall we do with NZB files           : Call SABnzbd through HTTP by Spotweb"
echo "| What shall we do with multiple NZB files? : Merge NZB files"
echo "| URL to SABnzbd                            : localhost:$INST_SABNZBD_PORT"
echo "| API key for SABnzbd                       : $INST_SABNZBD_KEY_API"
echo "-----------------------------------------------------------"
echo "| Change"
echo "-----------------------------------------------------------"
open http://localhost/spotweb

echo " --- press any key to continue ---"
read -n 1 -s

#osascript -e 'tell app "Terminal"
#    do script "php /Users/Spotweb/Sites/spotweb/retrieve.php"
#end tell'

[ -d /usr/local/share/spotweb ] || mkdir -p /usr/local/share/spotweb
cp /Users/Andries/Github/OSX_NewBox/bin/share/tmux_sync_spotweb.sh /usr/local/share/spotweb
cp /Users/Andries/Github/OSX_NewBox/bin/share/spotweb_cycle.sh /usr/local/share/spotweb
ln -s /usr/local/share/spotweb/tmux_sync_spotweb.sh /usr/local/bin/

[ -d /var/log/spotweb ] || sudo mkdir -p /var/log/spotweb && sudo chown `whoami` /var/log/spotweb

INST_FILE_LAUNCHAGENT="com.tmux.spotweb.plist"
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
    launchctl load ~/Library/LaunchAgents/$INST_FILE_LAUNCHAGENT
else
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | LaunchAgent file not found: ${RESET}"
    echo -e "${RED} | $DIR/conf/launchctl/$INST_FILE_LAUNCHAGENT  ${RESET}"
    echo -e "${RED} | --- press any key to continue --- ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    exit 1
fi

#------------------------------------------------------------------------------
# Install Spotweb - Complete
#------------------------------------------------------------------------------
