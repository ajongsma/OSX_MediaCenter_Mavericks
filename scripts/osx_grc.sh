#!/usr/bin/env bash
source config.sh

brew install grc
echo source "`brew --prefix`/etc/grc.bashrc" >> ~/.bash_profile

source ~/.bash_profile
