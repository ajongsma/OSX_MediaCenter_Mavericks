#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Plex Media Server - KPN iTV Online channel"
echo "#------------------------------------------------------------------------------"

source ../config.sh

# wget https://github.com/loek17/iTVOnline.bundle/archive/master.zip
# unzip master.zip
# rm master.zip
# mv iTVOnline.bundle-master iTVOnline.bundle

cd ~/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
git clone https://github.com/loek17/iTVOnline.bundle.git

echo "|------------------------------------------------------------------------------"
echo "| Don't forget to restart the Plex Media Server"
echo "|------------------------------------------------------------------------------"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s

echo "#------------------------------------------------------------------------------"
echo "# Plex Media Server - KPN iTV Online channel - Complete"
echo "#------------------------------------------------------------------------------"
