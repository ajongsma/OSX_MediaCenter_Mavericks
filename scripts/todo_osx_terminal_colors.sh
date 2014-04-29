#!/usr/bin/env bash
source config.sh

echo # This command tells termical to add color >> ~/.bash_profile
echo export CLICOLOR=1 >> ~/.bash_profile
echo export LSCOLORS=ExFxCxDxBxegedabagacad >> ~/.bash_profile
echo ""  >> ~/.bash_profile
echo # This command changes the terminal login colors >> ~/.bash_profile
echo PS1=’\[\e[0;33m\]\h:\W \u\$\[\e[m\] ‘ >> ~/.bash_profile

brew install grc
echo source "`brew --prefix`/etc/grc.bashrc" >> ~/.bash_profile

wget http://noahfrederick.com/get/Peppermint.1.2.terminal.zip >> ~/Downloads/Peppermint.1.2.terminal.zip
#wget https://github.com/dotzero/iTerm-2-Peppermint

source ~/.bash_profile
