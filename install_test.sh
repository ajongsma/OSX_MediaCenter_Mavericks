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

#PRINTF_MASK="%-50s %s %10s %s\n"
PRINTF_MASK="%-70s %s %10s %s\n"

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

function echo_fancy() {
  printf "\n%b\n" "$1"
}
#echo_fancy "Sample Updating Stuff ..."

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
# Install testing launcher
#------------------------------------------------------------------------------
if [[ $INST_SICKBEARD == "true" ]]; then
  source "$DIR/scripts/osx_homebrew.sh"
fi
