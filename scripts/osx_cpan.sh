#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#=============================================================================="
echo "# Installing CPAN plus modules"
echo "#------------------------------------------------------------------------------"
##https://forums.plex.tv/index.php/topic/72552-plexwatch-plex-notify-script-send-push-alerts-on-new-sessions-and-stopped/page-7

printf "$PRINTF_MASK" "Select No" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "Enter your user credentials" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "Click Sign In" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"



echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
cpan

sudo cpan install Time::Duration
sudo cpan install Time::ParseDate
sudo cpan install LWP::UserAgent
sudo cpan install XML::Simple
sudo cpan install DBI
sudo cpan install JSON

## Only Required if you use GNTP
#sudo cpan install Growl::GNTP

## Only required if you use Email
#sudo cpan install Net::SMTPS

echo "#------------------------------------------------------------------------------"
echo "# Installing CPAN plus modules - Complete"
echo "#=============================================================================="
