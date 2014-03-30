#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [ $HOSTNAME != "pooky.local" ]; then
    if [ -L config.sh ]; then
      rm config.sh
    fi
else
    echo "=> Pooky found"
fi

if [ ! -f config.sh ]; then
  clear
  echo "No config.sh found. Creating file, please edit the required values"
  cp config.sh.default config.sh
  vi config.sh
fi

source config.sh

if [[ $AGREED == "no" ]]; then
  echo "Please edit the config.sh file"
  exit
fi
