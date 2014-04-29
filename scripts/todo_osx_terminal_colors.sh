#!/usr/bin/env bash
source config.sh

## http://noiseandheat.com/blog/2011/12/os-x-lion-terminal-colours/
## http://redlinetech.wordpress.com/2013/02/01/how-to-add-colors-to-mac-terminal/

echo "# Add color to the terminal" >> ~/.bash_profile
echo "export CLICOLOR=1" >> ~/.bash_profile
echo "export LSCOLORS=ExFxCxDxBxegedabagacad" >> ~/.bash_profile
echo ""  >> ~/.bash_profile

#echo "# Changes the terminal login colors" >> ~/.bash_profile
#echo "PS1=’\[\e[0;33m\]\h:\W \u\$\[\e[m\] ‘" >> ~/.bash_profile

brew install grc
echo ""  >> ~/.bash_profile
echo "# Add grc to the terminal" >> ~/.bash_profile
echo source "`brew --prefix`/etc/grc.bashrc" >> ~/.bash_profile

## http://noahfrederick.com/blog/2011/lion-terminal-theme-peppermint/
#wget http://noahfrederick.com/get/Peppermint.1.2.terminal.zip >> ~/Downloads/Peppermint.1.2.terminal.zip
#git clone https://github.com/dotzero/iTerm-2-Peppermint

source ~/.bash_profile
