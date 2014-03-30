#!/usr/bin/env bash

echo "#------------------------------------------------------------------------------"
echo "# Enable Tap to Click for this user and for the login screen"
echo "#------------------------------------------------------------------------------"

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi


# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "#------------------------------------------------------------------------------"
echo "# Enabling Tap to Click for this user and for the login screen - Complete"
echo "#------------------------------------------------------------------------------"
