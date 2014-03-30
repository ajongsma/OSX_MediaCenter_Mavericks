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

#------------------------------------------------------------------------------
# Check for OS X Server 2.0
#------------------------------------------------------------------------------
if [[ $ENABLE_LIBRARY_UNHIDE == "true" ]]; then

  if [ ! -e /Applications/Server.app ] ; then
    printf "$PRINTF_MASK" "OS X Server not installed, please install..." "$RED" "[FAIL]" "$RESET"
    open https://itunes.apple.com/nl/app/os-x-server/id537441259?mt=12
    while ( [ ! -e /Applications/Server.app ] )
    do
        printf "$PRINTF_MASK" "Waiting for OS X Server to be installed…" "$YELLOW" "[WAIT]" "$RESET"
        sleep 15
    done
    printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"
    open /Applications/Server.app
    
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
  else
    printf "$PRINTF_MASK" "OS X Server found" "$GREEN" "[OK]" "$RESET"
  fi
  
  SERVICE='httpd'
  if ps ax | grep -v grep | grep $SERVICE > /dev/null ; then
    printf "$PRINTF_MASK" "$SERVICE' is running" "$GREEN" "[OK]" "$RESET"
  else
    printf "$PRINTF_MASK" "$SERVICE' is not running" "$RED" "[FAIL]" "$RESET"
    
    printf "$PRINTF_MASK" "Please enable:" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- Websites…" "$YELLOW" "[WAIT]" "$RESET"
    printf "$PRINTF_MASK" "- PHP Web Applications…" "$YELLOW" "[WAIT]" "$RESET"
    
    echo -e "${BLUE} --- press any key to abort --- ${RESET}"
    read -n 1 -s
    
    open /Applications/Server.app
    exit 1
  fi
fi
