#!/usr/bin/env bash
source config.sh

if [ ! -e /usr/local/bin/brew ] ; then
  printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
  exit 1
else
  printf "$PRINTF_MASK" "Installing extra utilities" "$RED" "[ERR]" "$RESET"
  
  brew update
  brew upgrade

  if [ -e /usr/local/bin/unrar ] ; then
    printf "$PRINTF_MASK" "Unrar detected" "$GREEN" "[OK]" "$RESET"
    exit 1
  else
    printf "$PRINTF_MASK" "Unrar not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    brew install unrar
    if [ $? != "0" ]; then
      printf "$PRINTF_MASK" "Error detected" "$RED" "[ERR]" "$RESET"
      exit 1
    else
      printf "$PRINTF_MASK" "No installation error detected" "$GREEN" "[OK]" "$RESET"
    fi
  fi
  
  if [ -e /usr/local/bin/mediainfo ] ; then
    printf "$PRINTF_MASK" "mediainfo detected" "$GREEN" "[OK]" "$RESET"
    exit 1
  else
    printf "$PRINTF_MASK" "mediainfo not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    brew install mediainfo
    if [ $? != "0" ]; then
      printf "$PRINTF_MASK" "Error detected" "$RED" "[ERR]" "$RESET"
      exit 1
    else
      printf "$PRINTF_MASK" "No installation error detected" "$GREEN" "[OK]" "$RESET"
    fi
  fi
  
  if [ -e /usr/local/bin/ffmpeg ] ; then
    printf "$PRINTF_MASK" "ffmpeg detected" "$GREEN" "[OK]" "$RESET"
    exit 1
  else
    printf "$PRINTF_MASK" "ffmpeg not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    brew install ffmpeg
    if [ $? != "0" ]; then
      printf "$PRINTF_MASK" "Error detected" "$RED" "[ERR]" "$RESET"
      exit 1
    else
      printf "$PRINTF_MASK" "No installation error detected" "$GREEN" "[OK]" "$RESET"
    fi
  fi
  
  if [ -e /usr/local/bin/lame ] ; then
    printf "$PRINTF_MASK" "lame detected" "$GREEN" "[OK]" "$RESET"
    exit 1
  else
    printf "$PRINTF_MASK" "lame not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
    brew install lame
    if [ $? != "0" ]; then
      printf "$PRINTF_MASK" "Error detected" "$RED" "[ERR]" "$RESET"
      exit 1
    else
      printf "$PRINTF_MASK" "No installation error detected" "$GREEN" "[OK]" "$RESET"
    fi
  fi
fi
