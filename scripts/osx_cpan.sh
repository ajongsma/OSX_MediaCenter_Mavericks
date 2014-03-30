#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing CPAN plus modules"
echo "#------------------------------------------------------------------------------"
##https://forums.plex.tv/index.php/topic/72552-plexwatch-plex-notify-script-send-push-alerts-on-new-sessions-and-stopped/page-7

cpan

sudo cpan install Time::Duration
sudo cpan install Time::ParseDate
sudo cpan install LWP::UserAgent
sudo cpan install XML::Simple
sudo cpan install DBI
sudo cpan install JSON
#sudo cpan install Growl::GNTP

echo "#------------------------------------------------------------------------------"
echo "# Installing CPAN plus modules - Complete"
echo "#------------------------------------------------------------------------------"
