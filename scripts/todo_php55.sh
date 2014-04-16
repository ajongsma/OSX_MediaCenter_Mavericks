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

