#!/usr/bin/env bash
source config.sh

brew install pcre
sudo pecl install apc

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Enable per request file info  : No"
echo "| Enable spin locks             : No"
echo "| Enable memory protection      : No"
echo "| Enable pthread mutexes        : No"
echo "-----------------------------------------------------------"
echo " --- press any key to continue ---"
read -n 1 -s


You should add "extension=apc.so" to php.ini
