#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Installing HomeBrew"
echo "#------------------------------------------------------------------------------"


#http://brew.sh

if ! which brew &>/dev/null; then
  fancy_echo "Installing Homebrew, a good OS X package manager ..."
    ruby <(curl -fsS https://raw.github.com/Homebrew/homebrew/go/install)

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    fancy_echo "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

fancy_echo "Updating Homebrew formulas ..."
brew update

echo "#------------------------------------------------------------------------------"
echo "# Installing HomeBrew - Complete"
echo "#------------------------------------------------------------------------------"

