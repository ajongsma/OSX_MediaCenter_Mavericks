#!/usr/bin/env bash
source config.sh


if [ ! -d $INST_SPOTWEB_PATH ] ; then
  printf "$PRINTF_MASK" "-> Spotweb not detected" "$RED" "[ERR]" "$RESET"
  echo " --- press any key to continue ---"
  read -n 1 -s
  exit 1
else

  #if [ ! -d ~/Library/Internet\ Plug-Ins/XML\ View\ Plugin.webplugin ] ; then
  #	cd ~/Downloads
  #	curl -O http://www2.entropy.ch/download/xmlviewplugin.zip
  #	unzip xmlviewplugin.zip
  #	mv XML\ View\ Plugin.webplugin/ ~/Library/Internet\ Plug-Ins/
  #fi
  
  #open http://localhost/spotweb/api?t=c
  
  URL="http://localhost/spotweb/api?t=c"
  TMPFILE=`mktemp /tmp/spotweb.XXXXXX`
  curl -s -o ${TMPFILE} ${URL} 2>/dev/null
  if [ "$?" -ne "0" ]; then
    printf "$PRINTF_MASK" "Unable to connect to ${URL}" "$RED" "[ERR]" "$RESET"
    echo " --- press any key to continue ---"
    read -n 1 -s
    exit 2
  fi
  RES=`grep -i "Spotweb API Index" ${TMPFILE}`
  if [ "$?" -ne "0" ]; then
    printf "$PRINTF_MASK" "String Spotweb API Index not found in ${URL}" "$RED" "[ERR]" "$RESET"
    printf "$PRINTF_MASK" "Copy the SpotWEB htaccess file and restart Apache" "$RED" "[ERR]" "$RESET"
    echo " --- press any key to continue ---
    read -n 1 -s
    exit 2
  else
    printf "$PRINTF_MASK" "echo "String Spotweb API Index not found in ${URL}"" "$RED" "[ERR]" "$RESET"
  fi
fi
