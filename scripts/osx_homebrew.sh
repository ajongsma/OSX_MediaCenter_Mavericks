#!/usr/bin/env bash

source config.sh
 
#if ! which brew &>/dev/null; then
if [ -e /usr/local/bin/brew ] ; then
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
  printf "$PRINTF_MASK" "Upgrading Homebrew formulas..." "$YELLOW" "[WAIT]" "$RESET"
  brew upgrade
  
  printf "$PRINTF_MASK" "Checking OS X Homebrew configuration..." "$YELLOW" "[WAIT]" "$RESET"
  brew doctor
  
  # Remove outdated versions from the cellar
  printf "$PRINTF_MASK" "Cleaning up..." "$YELLOW" "[WAIT]" "$RESET"
  brew cleanup
  
  if [ -e /usr/local/bin/brew ] ; then
    printf "$PRINTF_MASK" "Homebrew installed" "$GREEN" "[OK]" "$RESET"
  fi
fi

##### NOTE #####
## ash completion has been installed to:
##  /usr/local/etc/bash_completion.d
##
## zsh completion has been installed to:
##  /usr/local/share/zsh/site-functions
##
## If you need Python to find the installed site-packages:
##  mkdir -p ~/Library/Python/2.7/lib/python/site-packages
##  echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth
