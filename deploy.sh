#! /bin/bash
# script to deploy my personalisations

#VIM spelling customisations
ln -s ~/Documents/code/GeneralConfigs/.vim/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add

#strat of work to deploy mutt configs
ln -s ~/Documents/code/GeneralConfigs/mutt/.offlineimaprc ~/
mkdir -p ~/.mutt
cp -ra ~/Documents/code/GeneralConfigs/mutt/.mutt ~/.mutt
ln -s ~/Documents/code/GeneralConfigs/mutt/.offlineimaprc ~/

