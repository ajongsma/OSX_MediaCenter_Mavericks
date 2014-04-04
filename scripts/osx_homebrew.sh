#!/usr/bin/env bash

source config.sh
 printf "$PRINTF_MASK" "Homebrew detected" "$GREEN" "[OK]" "$RESET"
if ! which brew &>/dev/null; then

else
  printf "$PRINTF_MASK" "Homebrew not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  ruby <(curl -fsS https://raw.github.com/Homebrew/homebrew/go/install)

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    fancy_echo "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
fi


##### TESTING #####
exit 0
##### TESTING #####

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

