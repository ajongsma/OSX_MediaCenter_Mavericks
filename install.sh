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
  pico config.sh
fi

source config.sh

if [[ $AGREED == "no" ]]; then
  echo "Please edit the config.sh file"
  exit
fi

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREY=$(tput setaf 238)
ORANGE=$(tput setaf 172)
BOLD=$(tput bold)
UNDERLINE=$(tput sgr 0 1)
RESET=$(tput sgr0)

NOTICE=$RESET$BOLD$BLUE
SUCCESS=$RESET$BOLD$GREEN
FAILURE=$RESET$BOLD$RED
ATTENTION=$RESET$BOLD$ORANGE
INFORMATION=$RESET$BOLD$GREY

PRINTF_MASK="%-50s %s %10s %s\n"

TIMESTAMP=`date +%Y%m%d%H%M%S`
LOGFILE=$DIR/install-$TIMESTAMP.log

# Set to non-zero value for debugging
DEBUG=0


##-----------------------------------------------------------------------------
## Functions
##-----------------------------------------------------------------------------
function check_system() {
    # Check for supported system
    kernel=`uname -s`
    case $kernel in
        Darwin) ;;
        *) fail "Sorry, $kernel is not supported." ;;
    esac
}

##-----------------------------------------------------------------------------
## PreFlight - Check OS
##-----------------------------------------------------------------------------
check_system

#------------------------------------------------------------------------------
# Keep-alive: update existing sudo time stamp until finished
#------------------------------------------------------------------------------
# Ask for the administrator password upfront
echo "---------------------------------------------------"
echo "| Please enter the root password                  |"
echo "---------------------------------------------------"
sudo -v
echo "---------------------------------------------------"

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#------------------------------------------------------------------------------
# Checking if system is up-to-date
#------------------------------------------------------------------------------
## Run software update and reboot
if [[ $INST_OSX_UPDATES == "true" ]]; then
    echo "---------------------------------------------------"
    echo "| Checking and installing OS X software updates   |"
    echo "---------------------------------------------------"
    sudo softwareupdate --list
    sudo softwareupdate --install --all
fi

#------------------------------------------------------------------------------
# Show the ~/Library folder
#------------------------------------------------------------------------------
#chflags nohidden ~/Library
if [[ $ENABLE_LIBRARY_UNHIDE == "true" ]]; then
  echo "---------------------------------------------------"
  echo "| Unhiding hidden Library folder                  |"
  echo "---------------------------------------------------"
  chflags nohidden ~/Library
fi

#------------------------------------------------------------------------------
# Enable Tap to Click for this user and for the login screen
#------------------------------------------------------------------------------
if [[ $ENABLE_MOUSE_TAPTOCLICK == "true" ]]; then
  source "$DIR/scripts/osx_mouse_taptoclick_enable.sh"
fi

#------------------------------------------------------------------------------
# Checking existence directories
#------------------------------------------------------------------------------
source "$DIR/scripts/osx_folders_usenet.sh"
source "$DIR/scripts/osx_folders_media.sh"

#------------------------------------------------------------------------------
# Check for XLog
#------------------------------------------------------------------------------
if [[ $INSTALL_XLOG == "true" ]]; then
  source "$DIR/scripts/install_xlog.sh"
fi

#------------------------------------------------------------------------------
# Check for iTerm 2
#------------------------------------------------------------------------------
if [[ $INST_ITERM2 == "true" ]]; then
      source "$DIR/scripts/install_iterm.sh"
fi
#------------------------------------------------------------------------------
# Check for OS X Server 2.0
#------------------------------------------------------------------------------
if [[ $INSTALL_OSX_SERVER == "true" ]]; then
  source "$DIR/scripts/install_osx_server.sh"
fi

#------------------------------------------------------------------------------
# Install Plex Server
#------------------------------------------------------------------------------
if [[ $INST_PLEX_MEDIA_SERVER == "true" ]]; then
    source "$DIR/scripts/install_plex_server.sh"
fi

#------------------------------------------------------------------------------
# Install Plex Watch
#------------------------------------------------------------------------------
if [[ $INST_PLEXWATCH == "true" ]]; then
    source "$DIR/scripts/install_plex_server_plexwatch.sh"
fi


#------------------------------------------------------------------------------
# Install Plex Server
#------------------------------------------------------------------------------
if [[ $INST_PLEX_HOME_THEATER == "true" ]]; then
    source "$DIR/scripts/install_plex_client.sh"
fi

