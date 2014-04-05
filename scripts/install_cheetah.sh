#!/usr/bin/env bash
source config.sh

if [ -e /usr/local/bin/cheetah ] ; then
  printf "$PRINTF_MASK" "-> Cheetah detected\n" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "-> Cheetah not detected, installing...\n" "$YELLOW" "[WAIT]" "$RESET"

  echo "Download latest Cheetah from http://www.cheetahtemplate.org/download"
  open http://www.cheetahtemplate.org/download

  cd ~/Downloads
  printf 'Waiting for Cheetah to be downloaded…\n' "$YELLOW" $col '[WAIT]' "$RESET"
  while ( [ ! -e Cheetah-2.4.4.tar ] )
  do
      printf '.'
      sleep 2
  done
  printf 'Cheetah downloaded, installing...\n' "$YELLOW" $col '[WAIT]' "$RESET"
  tar xvzf Cheetah-2.4.4.tar
  cd Cheetah-2.4.4
  sudo python setup.py install

  if [ -e /usr/local/bin/cheetah ] ; then
    printf "$PRINTF_MASK" "-> Cheetah installed\n" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "-> Cheetah not installed\n" "$RED" "[ERR]" "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
  fi
  
  cd $DIR
fi
