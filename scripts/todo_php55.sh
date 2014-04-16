#!/usr/bin/env bash
source config.sh

#/usr/local/Library/Taps/josegonzalez-php
brew tap josegonzalez/homebrew-php

brew update
brew upgrade
brew cleanup

brew install tidy
#brew install php55 --with-pgsql --with-mysql --with-tidy --with-intl --with-gmp
brew install php55 --with-mysql --with-tidy --with-intl --with-gmp

#/usr/local/etc/php/5.5/php.ini

brew install php55-intl
brew install php55-ssh2
brew install php55-mcrypt

#ln -sfv /usr/local/opt/php55/*.plist ~/Library/LaunchAgents
#launchctl load ~/Library/LaunchAgents/homebrew.mxcl.php55.plist

brew install php55-memcached
ln -sfv /usr/local/opt/memcached/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.memcached.plist
