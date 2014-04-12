#!/usr/bin/env bash
source config.sh

## http://www.newznab.com/
## http://www.newznabforums.com/

function check_config_defaults() {
if [[ -z $INST_NEWZNAB_SVN_UID ]] || [[ -z $INST_NEWZNAB_SVN_PW ]] || [[ -z $INST_NEWZNAB_PATH ]]; then
  printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
  echo "| NewzNAB SVN Username        : INST_NEWZNAB_SVN_UID"
  echo "| NewzNAB SVN Password        : INST_NEWZNAB_SVN_PW"
  echo "| NewzNAB Path                : INST_NEWZNAB_PATH"
  if [ ! -d /Applications/TextWrangler.app ]; then
    pico config.sh
  else
    open -a /Applications/TextWrangler.app config.sh
  fi
  while ( [[ $INST_NEWZNAB_SVN_UID == "" ]] || [[ $INST_NEWZNAB_SVN_PW == "" ]] || [[ $INST_NEWZNAB_PATH == "" ]] )
  do
    printf '.'
    sleep 2
    source config.sh
  done
  printf '.\n'
  printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
fi

if [[ -z $INST_MYSQL_UID ]] || [[ -z $INST_MYSQL_PW ]] ; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| MySQL Username              : INST_MYSQL_UID"
    echo "| MySQL Password              : INST_MYSQL_PW"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_MYSQL_UID == "" ]] || [[ $INST_MYSQL_PW == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf '.\n'
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
  
  if [[ -z $INST_NEWZNAB_MYSQL_UID ]] || [[ -z $INST_NEWZNAB_MYSQL_PW ]] || [[ -z $INST_NEWZNAB_MYSQL_DB ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| Spotweb Username            : INST_NEWZNAB_MYSQL_UID"
    echo "| Spotweb Password            : INST_NEWZNAB_MYSQL_PW"
    echo "| Spotweb Path                : INST_NEWZNAB_MYSQL_DB"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_NEWZNAB_MYSQL_UID == "" ]] || [[ $INST_NEWZNAB_MYSQL_PW == "" ]] || [[ $INST_NEWZNAB_MYSQL_DB == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf '.\n'
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi

  if [[ -z $INST_NEWSSERVER_SERVER ]] || [[ -z $INST_NEWSSERVER_SERVER_UID ]] || [[ -z $INST_NEWSSERVER_SERVER_PW ]] || [[ -z $INST_NEWSSERVER_SERVER_PORT_SSL ]]; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| News Server                 : INST_NEWSSERVER_SERVER"
    echo "| News Server Port SSL        : INST_NEWSSERVER_SERVER_PORT_SSL"
    echo "| News Server Username        : INST_NEWSSERVER_SERVER_PW"
    echo "| News Server Password        : INST_NEWSSERVER_SERVER_UID"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_NEWSSERVER_SERVER == "" ]] || [[ $INST_NEWSSERVER_SERVER_UID == "" ]] || [[ $INST_NEWSSERVER_SERVER_PW == "" ]] || [[ $INST_NEWSSERVER_SERVER_PORT_SSL == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf '.\n'
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}


#if [ ! -h $INST_APACHE_SYSTEM_WEB_ROOT/newznab ] ; then
if [ -h $INST_APACHE_SYSTEM_WEB_ROOT/newznab ] ; then
  printf "$PRINTF_MASK" "-> NewzNAB detected" "$GREEN" "[OK]" "$RESET"
  echo "-> $INST_APACHE_SYSTEM_WEB_ROOT/newznab"
  check_config_defaults
  #check_config_var
else
  printf "$PRINTF_MASK" "-> NewzNAB not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults
  
  if [ ! -d $INST_NEWZNAB_PATH ] ; then
    printf "$PRINTF_MASK" $INST_NEWZNAB_PATH" does't exists, creating" "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_NEWZNAB_PATH
    sudo chown `whoami` $INST_NEWZNAB_PATH
  else
    printf "$PRINTF_MASK" $INST_NEWZNAB_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi
  
  if [ ! -d $INST_NEWZNAB_PATH/www ] ; then
    printf "$PRINTF_MASK" " NewzNAB does't exists, downloading" "$YELLOW" "[WAIT]" "$RESET"
    cd $INST_NEWZNAB_PATH
    echo "svn co svn://svn.newznab.com/nn/branches/nnplus/ --username $INST_NEWZNAB_SVN_UID --password $INST_NEWZNAB_SVN_PW $INST_NEWZNAB_PATH"
    echo "------------------------------------------"
    echo " NewzNAB SVN"
    echo "------------------------------------------"
    echo " Username: $INST_NEWZNAB_SVN_UID"
    echo " Password: $INST_NEWZNAB_SVN_PW"
    echo "------------------------------------------"
    svn co svn://svn.newznab.com/nn/branches/nnplus/ --username $INST_NEWZNAB_SVN_UID --password $INST_NEWZNAB_SVN_PW $INST_NEWZNAB_PATH
  
    if [ ! -d $INST_NEWZNAB_PATH/nzbfiles/tmpunrar ] ; then
      printf "$PRINTF_MASK" $INST_NEWZNAB_PATH"/nzbfiles/tmpunrareating doesn't exist, creating" "$YELLOW" "[WAIT]" "$RESET"
      mkdir -p $INST_NEWZNAB_PATH/nzbfiles/tmpunrar
    else
      printf "$PRINTF_MASK" $INST_NEWZNAB_PATH" exists" "$GREEN" "[OK]" "$RESET"
    fi
    sudo chmod 777 $INST_NEWZNAB_PATH/www/lib/smarty/templates_c
    sudo chmod 777 $INST_NEWZNAB_PATH/www/covers/movies
    sudo chmod 777 $INST_NEWZNAB_PATH/www/covers/anime
    sudo chmod 777 $INST_NEWZNAB_PATH/www/covers/music
    sudo chmod 777 $INST_NEWZNAB_PATH/www
    sudo chmod 777 $INST_NEWZNAB_PATH/www/install
    sudo chmod 777 $INST_NEWZNAB_PATH/db
    sudo chmod -R 777 $INST_NEWZNAB_PATH/nzbfiles/
  else
    printf "$PRINTF_MASK" "NewzNAB exists" "$GREEN" "[OK]" "$RESET"
  fi

  cd $DIR
  if [ ! -h $INST_APACHE_SYSTEM_WEB_ROOT/newznab ]; then
    printf "$PRINTF_MASK" "Symbolic link not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
    sudo ln -sfv $INST_NEWZNAB_PATH/www $INST_APACHE_SYSTEM_WEB_ROOT/newznab
    sudo chown `whoami` $INST_APACHE_SYSTEM_WEB_ROOT/newznab
  else
    printf "$PRINTF_MASK" "Symbolic link detected" "$GREEN" "[OK]" "$RESET"
  fi
  
  MYSQL=`which mysql`
  DBEXISTS=$(MYSQL -u root -p$INST_MYSQL_PW --batch --skip-column-names -e "SHOW DATABASES LIKE '"$INST_NEWZNAB_MYSQL_DB"';" | grep "$INST_NEWZNAB_MYSQL_DB" > /dev/null; echo "$?")
  if [ $DBEXISTS -eq 0 ]; then
    printf "$PRINTF_MASK" "Spotweb database $INST_NEWZNAB_MYSQL_DB exists" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "Spotweb database $INST_NEWZNAB_MYSQL_DB doesn't exists, creating..." "$YELLOW" "[WAIT]" "$RESET"
  
    DB="create database $INST_NEWZNAB_MYSQL_DB;GRANT ALL PRIVILEGES ON $INST_NEWZNAB_MYSQL_DB.* TO $INST_NEWZNAB_MYSQL_UID@localhost IDENTIFIED BY '$INST_NEWZNAB_MYSQL_PW';FLUSH PRIVILEGES;"
    echo "-> DB: " $DB
    echo "-> PW: " $INST_MYSQL_PW
    MYSQL -u root -p$INST_MYSQL_PW -e "$DB"
    if [ $? != "0" ]; then
      echo "[Error]: Database creation failed"
      exit 1
    else
      echo "------------------------------------------"
      echo " Database has been created successfully "
      echo "------------------------------------------"
      echo " DB Info: "
      echo ""
      echo " DB Name: $INST_NEWZNAB_MYSQL_DB"
      echo " DB User: $INST_NEWZNAB_MYSQL_UID"
      echo " DB Pass: $INST_NEWZNAB_MYSQL_PW"
      echo ""
      echo "------------------------------------------"
    fi
  fi

  echo "-----------------------------------------------------------"
  echo "| NewzNAB Installer"
  echo "-----------------------------------------------------------"
  echo "| Click                         : Go to step one: Pre flight check"
  echo "| Check                         : All results should be OK"
  echo "| Click                         : Go to step two: Set up the database"
  echo "-----------------------------------------------------------"
  open http://localhost/newznab
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Paste the information as seen in the installer:"
  echo "| Hostname                      : 127.0.0.1"
  echo "| Port                          : 3306"
  echo "| Username                      : $INST_NEWZNAB_MYSQL_UID"
  echo "| Password                      : $INST_NEWZNAB_MYSQL_PW"
  echo "| Database                      : $INST_NEWZNAB_MYSQL_DB"
  echo "| DB Engine                     : MyISAM"
  echo "-----------------------------------------------------------"
  echo "| Setup Database, Setup three: Setup news server connection"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| News Server Setup:"
  echo "| Server                        : $INST_NEWSSERVER_SERVER"
  echo "| User Name                     : $INST_NEWSSERVER_SERVER_UID"
  echo "| Password                      : $INST_NEWSSERVER_SERVER_PW"
  echo "| Port                          : $INST_NEWSSERVER_SERVER_PORT_SSL"
  echo "| SSL                           : Enable"
  echo "-----------------------------------------------------------"
  echo "| Test connection"
  echo "-----------------------------------------------------------"
  #open http://localhost/newznab/admin/site-edit.php
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

#  echo "-----------------------------------------------------------"
#  echo "| Caching Setup:"
#  echo "| Caching Type                  : Memcache"
#  echo "-----------------------------------------------------------"

  echo "-----------------------------------------------------------"
  echo "| Caching Setup"
  echo "-----------------------------------------------------------"
  echo "| Caching Type                  : APC"
  echo "-----------------------------------------------------------"
  echo "| Save configuration file, Step five: Setup admin user"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Username                      : $INST_NEWZNAB_UID"
  echo "| Password                      : $INST_NEWZNAB_PW"
  echo "| Email                         : <Email address>"
  echo "-----------------------------------------------------------"
  echo "| Create Admin user, Step Seven: Set NZB File Path"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
  echo "-----------------------------------------------------------"
  echo "| Location                      : $INST_NEWZNAB_PATH/nzbfiles/"
  echo "-----------------------------------------------------------"
  echo "| Set NZB File Path"
  echo "-----------------------------------------------------------"
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

## => Note: It is a good idea to remove the www/install directory after setup


#### TESTING ######################################


  echo "-----------------------------------------------------------"
  echo "| Site Edit"
#  echo "-----------------------------------------------------------"
#  echo "| NZB File Path Setup           : $INST_NEWZNAB_PATH/nzbfiles/"
  echo "-----------------------------------------------------------"
  echo "| Main Site Settings, HTML Layout, Tags"
  echo "| - newznab ID                  : $INST_NEWZNAB_NNPLUS_ID"
  echo "| "
  echo "| 3rd Party Application Paths"

  UNRAR=`which mysql`
  if [[ ! -z $UNRAR ]]
    echo "| - Unrar Path                    : $UNRAR"
  fi
  MEDIAINFO=`which mysql`
  if [[ ! -z MEDIAINFO ]]
    echo "| - MediaInfo Path                : $MEDIAINFO"
  fi
  FFMPEG=`which ffmpeg`
  if [[ ! -z FFMPEG ]]
    echo "| - FFMPeg Path                   : $FFMPEG"
  fi
  LAME=`which lame`
  if [[ ! -z LAME ]]
    echo "| - Lame Path                     : $LAME"
  fi
  echo "| "
  echo "| Usenet Settings"
  echo "| - Minimum Completion Percent    : 95"
  echo "| - Start new groups              : Days, 1"
  echo "| "
  echo "| Check For Passworded Releases : Deep"
  echo "| Delete Passworded Releases    : Yes"
  echo "| Show Passworded Releases      : Show everything"
  echo "-----------------------------------------------------------"
  open http://localhost/newznab/admin/site-edit.php
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s

  echo "-----------------------------------------------------------"
  echo "| Enable categories:"
  echo "| a.b.teevee"
  echo "|"
  echo "| For extended testrun:"
  echo "| a.b.multimedia"
  echo "-----------------------------------------------------------"
  open http://localhost/newznab/admin/group-list.php
  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
  read -n 1 -s
  
#  echo "-----------------------------------------------------------"
#  echo "| Add the following newsgroup:"
#  echo "| Name                          : alt.binaries.nl"
#  echo "| Backfill Days                 : 1"
#  echo "-----------------------------------------------------------"
#  open http://localhost/newznab/admin/group-edit.php
#  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#  read -n 1 -s
#  
#  echo "-----------------------------------------------------------"
#  echo "| Add the following RegEx:"
#  echo "| Group                         : alt.binaries.nl"
#  echo "| RegEx                         : /^.*?"(?P<name>.*?)\.(sample|mkv|Avi|mp4|vol|ogm|par|rar|sfv|nfo|nzb|web|rmvb|srt|ass|mpg|txt|zip|wmv|ssa|r\d{1,3}|7z|tar|cbr|cbz|mov|divx|m2ts|rmvb|iso|dmg|sub|idx|rm|t\d{1,2}|u\d{1,3})/iS""
#  echo "| Ordinal                       : 5"
#  echo "-----------------------------------------------------------"
#  open http://localhost/newznab/admin/regex-edit.php?action=add
#  echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#  read -n 1 -s

  source config.sh
  if [[ $INST_NEWZNAB_KEY_API == "" ]]; then
    echo "-----------------------------------------------------------"
    echo "| Main Site Settings, API:"
    echo "| Please add the NewzNAB API key to config.sh"
    echo "-----------------------------------------------------------"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    open  http://localhost/newznab/admin/site-edit.php
    
    printf "$PRINTF_MASK" "NewzNAB API key not detected, please added to config.sh" "$YELLOW" "[WAIT]" "$RESET"
    while ( [[ $INST_NEWZNAB_KEY_API == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf '.\n'
    printf "$PRINTF_MASK" "NewzNAB API key detected" "$GREEN" "[OK]" "$RESET"
  fi

  if [ -f $DIR/config/newznab/newznab_local.sh ] ; then
    sudo cp $DIR/config/newznab/newznab_local.sh $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
  else
    echo "-----------------------------------------------------------"
    echo "| Update the following:"
    echo "| export NEWZNAB_PATH="$INST_NEWZNAB_PATH/misc/update_scripts""
    echo "|"
    echo "| Modify all PHP5 references"
    echo "| /usr/bin/php5 ... => php ..."
    cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
    cp newznab_screen.sh newznab_local.sh
    chmod +x newznab_local.sh
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico newznab_local.sh
    else
      open -a /Applications/TextWrangler.app newznab_local.sh
    fi
  fi
  
  echo "-----------------------------------------------------------"
  echo "| Update file update_parsing.php:"
  echo "| \$echo = true;                 : \$echo = false;"
  echo "-----------------------------------------------------------"
  if [ ! -d /Applications/TextWrangler.app ]; then
    pico $INST_NEWZNAB_PATH/misc/testing/update_parsing.php
  else
    open -a /Applications/TextWrangler.app $INST_NEWZNAB_PATH/misc/testing/update_parsing.php
  fi
  
  cd $INST_NEWZNAB_PATH/misc/update_scripts/nix_scripts/
  sh ./newznab_local.sh


  cd $DIR
fi

##### TESTING #####
exit 0
##### TESTING #####

#------------------------------------------------------------------------------
# Install NewzNAB
#------------------------------------------------------------------------------
## http://www.newznabforums.com

#echo "-----------------------------------------------------------"
#echo "Enter the httpd.conf:"
#echo "<Directory /Library/WebServer/Documents/newznab>"
#echo "    Options FollowSymLinks"
#echo "    AllowOverride All"
#echo "    Order deny,allow"
#echo "    Allow from all"
#echo "</Directory>"
#echo "-----------------------------------------------------------"
#sudo subl /etc/apache2/httpd.conf

#echo "----------------------------------------------------------"
#echo "| Add an alias and enable htaccess for NewzNAB to the default website:"
#echo "| Create alias in Server Website"
#echo "|   Path                        : /newzab"
#echo "|   Folder                      : $INST_NEWZNAB_PATH/www"
#echo "| Enable overrides using .htaccess files"
#echo "-----------------------------------------------------------"
#open /Applications/Server.app
#echo -e "${BLUE} --- press any key to continue --- ${RESET}"
#read -n 1 -s

## Create the NewzNAB MySQL user and DB
#MYSQL=`which mysql`
#
#Q1="CREATE DATABASE IF NOT EXISTS $INST_NEWZNAB_MYSQL_DB;"
#Q2="GRANT USAGE ON *.* TO $INST_NEWZNAB_MYSQL_UID@localhost IDENTIFIED BY '$INST_NEWZNAB_MYSQL_PW';"
#Q3="GRANT ALL PRIVILEGES ON $INST_NEWZNAB_MYSQL_DB.* TO $INST_NEWZNAB_MYSQL_UID@localhost;"
#Q4="FLUSH PRIVILEGES;"
#SQL="${Q1}${Q2}${Q3}${Q4}"
#
#MYSQL -u root -p -e "$SQL"


## --- TESTING




# -----------------------------------------------------------"
#| Installing LaunchAgent plus scripts
# -----------------------------------------------------------"
[ -d /usr/local/share/newznab ] || mkdir -p /usr/local/share/newznab
cp /Users/Andries/Github/OSX_NewBox/bin/share/tmux_sync_newznab.sh /usr/local/share/newznab
cp /Users/Andries/Github/OSX_NewBox/bin/share/newznab_cycle.sh /usr/local/share/newznab
ln -s /usr/local/share/newznab/tmux_sync_newznab.sh /usr/local/bin/

[ -d /var/log/newznab ] || sudo mkdir -p /var/log/newznab && sudo chown `whoami` /var/log/newznab

INST_FILE_LAUNCHAGENT="com.tmux.newznab.plist"
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
# Install NewzNAB - Complete
#------------------------------------------------------------------------------
