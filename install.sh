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
#  # Check for supported system
#  kernel=`uname -s`
#  case $kernel in
#      Darwin) ;;
#      *) fail "Sorry, $kernel is not supported." ;;
#  esac
  if [[ $TYPE != "force" ]]; then
  	OS_VERSION=`sw_vers -productVersion | grep -o 10\..`
  	if [[ $OS_VERSION == "10.9" ]]; then
  		echo "Detected OS X Mavericks 10.9. All ok."
  	elif [[ $OS_VERSION == "10.8" ]]; then
  		echo "Detected OS X Mountain Lion 10.8. All ok."
  	elif [[ $OS_VERSION == "10.7" ]]; then
  		echo "Detected OS X Lion 10.7. All ok."
  	elif [[ $OS_VERSION == "10.6" ]]; then
  		echo "Detected OS X Snow Leopard 10.6. All ok."
  	else
  		echo "****"
  		echo "Your version of OS X ($OS_VERSION) is not supported, you need at least 10.6"
  		echo "Stopping installation..."
  		echo "****"
  		exit 2
  	fi
  	HAS64BIT=`sysctl -n hw.cpu64bit_capable 2> /dev/null`
  	if [[ $HAS64BIT != 1 ]]; then
  		echo "****"
  		echo "ERROR! 32 BIT NOT SUPPORTED!"
  		echo "****"
  		echo "No 64bit capable system found. Your hardware is out of date."
  		echo "****"
  		exit 1
  	fi
  fi
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
# Enable the locate database
#------------------------------------------------------------------------------
if [[ $ENABLE_LOCATE_DATABASE == "true" ]]; then
  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
fi


#------------------------------------------------------------------------------
# Enable Tap to Click for this user and for the login screen
#------------------------------------------------------------------------------
if [[ $ENABLE_MOUSE_TAPTOCLICK == "true" ]]; then
  source "$DIR/scripts/osx_mouse_taptoclick_enable.sh"
fi

#------------------------------------------------------------------------------
# Install HomeBrew
#------------------------------------------------------------------------------
if [[ $INSTALL_HOMEBREW == "true" ]]; then
  source "$DIR/scripts/osx_homebrew.sh"
fi

#------------------------------------------------------------------------------
# Install MySQL
#------------------------------------------------------------------------------
if [[ $INST_MYSQL == "true" ]]; then
  source "$DIR/scripts/install_mysql.sh"
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
# Check for iTerm 2
#------------------------------------------------------------------------------
if [[ $INST_TEXTWRANGLER == "true" ]]; then
  source "$DIR/scripts/install_textwrangler.sh"
fi

#------------------------------------------------------------------------------
# Check for MacPAR Deluxe
#------------------------------------------------------------------------------
if [[ $INST_MACPAR == "true" ]]; then
  source "$DIR/scripts/install_macpar.sh"
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
# Install Plex Server - TraktTV
#------------------------------------------------------------------------------
if [[ $INST_PLEX_MEDIA_SERVER_TRAKT == "true" ]]; then
  source "$DIR/scripts/install_plex_server_trakttv.sh"
fi

#------------------------------------------------------------------------------
# Install Plex Watch
#------------------------------------------------------------------------------
if [[ $INST_PLEXWATCH == "true" ]]; then
  source "$DIR/scripts/osx_cpan.sh"
  source "$DIR/scripts/install_plex_server_plexwatch.sh"
fi

#------------------------------------------------------------------------------
# Install Plex Watch Web
#------------------------------------------------------------------------------
if [[ $INST_PLEXWATCHWEB == "true" ]]; then
  source "$DIR/scripts/install_plex_server_plexwatchweb.sh"
fi

#------------------------------------------------------------------------------
# Install Plex Home Theater
#------------------------------------------------------------------------------
if [[ $INST_PLEX_HOME_THEATER == "true" ]]; then
  source "$DIR/scripts/install_plex_client.sh"
fi

#------------------------------------------------------------------------------
# Install SABnzbd
#------------------------------------------------------------------------------
if [[ $INST_SABNZBD == "true" ]]; then
  source "$DIR/scripts/install_sabnzbd.sh"
fi

#------------------------------------------------------------------------------
# Install CouchPotato
#------------------------------------------------------------------------------
if [[ $INST_COUCHPOTATO == "true" ]]; then
  source "$DIR/scripts/install_couchpotato.sh"
  source "$DIR/scripts/install_couchpotato_pms.sh"
  source "$DIR/scripts/install_couchpotato_trakttv.sh"
fi

#------------------------------------------------------------------------------
# Install SickBeard
#------------------------------------------------------------------------------
if [[ $INST_SICKBEARD == "true" ]]; then
  source "$DIR/scripts/install_cheetah.sh"
  source "$DIR/scripts/install_sickbeard.sh"
  source "$DIR/scripts/install_sickbeard_sabscripts.sh"
  source "$DIR/scripts/install_sabnzbd_sickbeard.sh"
  source "$DIR/scripts/install_sickbeard_pms.sh"
  source "$DIR/scripts/install_sickbeard_trakttv.sh"
fi

#------------------------------------------------------------------------------
# Install nzbToMedia
#------------------------------------------------------------------------------
if [[ $INST_NZBTOMEDIA == "true" ]]; then
  source "$DIR/scripts/install_nzbtomedia.sh"
fi

#------------------------------------------------------------------------------
# Install SabNZBD to CouchPotato via nzbToMedia
#------------------------------------------------------------------------------
if [[ $INST_SABNZBD == "true" ]] || [[ $INST_COUCHPOTATO == "true" ]] || [[ $INST_NZBTOMEDIA == "true" ]]; then
  source "$DIR/scripts/install_sabnzbd_couchpotato.sh"
fi

#------------------------------------------------------------------------------
# Install Auto-Sub
#------------------------------------------------------------------------------
if [[ $INST_AUTOSUB == "true" ]]; then
  source "$DIR/scripts/osx_pear.sh"
  source "$DIR/scripts/install_autosub.sh"
fi

#------------------------------------------------------------------------------
# Install SpotWEB
#------------------------------------------------------------------------------
if [[ $INST_SPOTWEB == "true" ]]; then
  source "$DIR/scripts/osx_php55.sh"
  source "$DIR/scripts/install_spotweb.sh"
  source "$DIR/scripts/install_spotweb_api.sh"
  source "$DIR/scripts/install_spotweb_sabnzbd.sh"
  if [[ $INST_SICKBEARD == "true" ]]; then
    source "$DIR/scripts/install_sickbeard_spotweb.sh"
    source "$DIR/scripts/install_sickbeard_spotweb.sh"
  fi
fi

