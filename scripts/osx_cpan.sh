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

printf "$PRINTF_MASK" "Would you like to configure as much as possible automatically? -> yes" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "What approach do you want? -> local::lib" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "Would you like me to automatically choose some CPAN mirror sites for you?? -> yes" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "After CPAN has finished, enter Q to exit" "$YELLOW" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$YELLOW" "[WAIT]" "$RESET"
echo -e "${BLUE} --- press any key to continue --- ${RESET}"
read -n 1 -s
cpan

printf "$PRINTF_MASK" "-----------------------------------" "$GREY" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "Installing extra modules..." "$GREY" "[WAIT]" "$RESET"
printf "$PRINTF_MASK" "-----------------------------------" "$GREY" "[WAIT]" "$RESET"
sudo cpan install Time::Duration
sudo cpan install JSON
sudo cpan install Time::ParseDate
sudo cpan install File::ReadBackwards

#sudo cpan install LWP::UserAgent
#sudo cpan install XML::Simple
#sudo cpan install DBI

## Only required if you use GNTP
#sudo cpan install Growl::GNTP

## Only required if you use Email
#sudo cpan install Net::SMTPS

#./plexWatch.pl --test_notify=start
echo "#------------------------------------------------------------------------------"
echo "# Installing CPAN plus modules - Complete"
echo "#=============================================================================="
