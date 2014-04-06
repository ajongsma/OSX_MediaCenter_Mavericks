#!/usr/bin/env bash

source config.sh
 
if ! which brew &>/dev/null; then
 printf "$PRINTF_MASK" "Homebrew detected" "$GREEN" "[OK]" "$RESET"
else
  printf "$PRINTF_MASK" "Homebrew not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  ruby <(curl -fsS https://raw.github.com/Homebrew/homebrew/go/install)

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
    fancy_echo "Put Homebrew location earlier in PATH ..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
  printf "$PRINTF_MASK" "Updating Homebrew formulas..." "$YELLOW" "[WAIT]" "$RESET"
  # Make sure we’re using the latest Homebrew
  brew update
  
  # Upgrade any already-installed formulae
  brew upgrade
  
  brew doctor
  
  # Remove outdated versions from the cellar
  brew cleanup
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

#### SOME OTHER SCRIPT

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
if [ ! -e /usr/local/bin/brew ] ; then
    printf 'HomeBrew failed installing\n' "$RED" $col '[FAIL]' "$RESET"
    echo -e "${BLUE} --- press any key to continue --- ${RESET}"
    read -n 1 -s
    exit 1
else
    printf 'HomeBrew found\n' "$GREEN" $col '[OK]' "$RESET"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew doctor

# Remove outdated versions from the cellar
brew cleanup
