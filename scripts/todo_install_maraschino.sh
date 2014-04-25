#!/usr/bin/env bash
source config.sh

function check_config_defaults() {
  if [[ -z $INST_MARASCHINO_PATH ]] ; then
    printf 'One or more values were not detected in the config.sh, please add the appropriate values:\n' "YELLOW" $col '[WAIT]' "$RESET"
    echo "| Maraschino Path             : INST_MARASCHINO_PATH"
    if [ ! -d /Applications/TextWrangler.app ]; then
      pico config.sh
    else
      open -a /Applications/TextWrangler.app config.sh
    fi
    while ( [[ $INST_MARASCHINO_PATH == "" ]] )
    do
      printf '.'
      sleep 2
      source config.sh
    done
    printf '.\n'
    printf "$PRINTF_MASK" "." "$GREEN" "[OK]" "$RESET"
  fi
}


## https://github.com/gugahoi/maraschino

if [ -h $INST_APACHE_SYSTEM_WEB_ROOT/maraschino ] ; then
  printf "$PRINTF_MASK" "-> Symoblic link to Maraschino detected" "$GREEN" "[OK]" "$RESET"
  check_config_defaults
else
  printf "$PRINTF_MASK" "-> Maraschino not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  check_config_defaults

  if [ ! -d $INST_MARASCHINO_PATH ] ; then
    printf "$PRINTF_MASK" $INST_MARASCHINO_PATH" does't exists, creating" "$YELLOW" "[WAIT]" "$RESET"
    sudo mkdir -p $INST_MARASCHINO_PATH
    sudo chown `whoami` $INST_MARASCHINO_PATH
  else
    printf "$PRINTF_MASK" $INST_MARASCHINO_PATH" exists" "$GREEN" "[OK]" "$RESET"
  fi
  
  cd $INST_MARASCHINO_PATH
  if [ ! -d $INST_MARASCHINO_PATH/maraschino ]; then
    printf "$PRINTF_MASK" $INST_MARASCHINO_PATH"/maraschino does't exists, downloading..." "$YELLOW" "[WAIT]" "$RESET"
    #sudo git clone https://github.com/gugahoi/maraschino.git
    sudo git clone https://github.com/gugahoi/maraschino.git plex
    sudo chown `whoami` $INST_MARASCHINO_PATH/maraschino
  else
    printf "$PRINTF_MASK" $INST_MARASCHINO_PATH"/maraschino exists, updating..." "$YELLOW" "[WAIT]" "$RESET"
    #git pull https://github.com/gugahoi/maraschino.git
    git pull https://github.com/gugahoi/maraschino.git plex
  fi
  
#  if [ -d $INST_MARASCHINO_PATH/maraschino ]; then
#    printf "$PRINTF_MASK" $INST_MARASCHINO_PATH"/maraschino exists" "$GREEN" "[OK]" "$RESET"
#    if [ ! -h $INST_APACHE_SYSTEM_WEB_ROOT/maraschino ]; then
#      printf "$PRINTF_MASK" "Symbolic link not detected, creating..." "$YELLOW" "[WAIT]" "$RESET"
#      sudo ln -sfv $INST_MARASCHINO_PATH/maraschino /Library/Server/Web/Data/Sites/Default/maraschino
#      sudo chown `whoami` /Library/Server/Web/Data/Sites/Default/maraschino
#      #sudo ln -s $INST_SPOTWEB_PATH/Sites/spotweb /Library/Server/Web/Data/Sites/Default/spotweb
#    else
#      printf "$PRINTF_MASK" "Symbolic link detected" "$GREEN" "[OK]" "$RESET"
#    fi
#  else
#    printf "$PRINTF_MASK" $INST_MARASCHINO_PATH"/maraschino doesn't exists" "$RED" "[ERR]" "$RESET"
#  fi
  
  open http://localhost/maraschino
  
fi
