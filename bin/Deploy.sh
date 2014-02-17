#!/bin/bash
#script to deploy all the configs and files if not already done

#make the backup area first
mkdir -p ~/deployment_backups 

#install the scripts
mkdir -p ~/bin
rsync -avb --backup-dir=~/deployment_backups ../bin/ ~/bin

#install the bash customisations
rsync -avb --backup-dir=~/deployment_backups .bash_profile ~/
rsync -avb --backup-dir=~/deployment_backups .bashrc ~/
rsync -avb --backup-dir=~/deployment_backups .profile ~/

#install the VIM customisations
mkdir -p ~/.vim/skel/
rsync -avb --backup-dir=~/deployment_backups .vim/skel/tmpl.pl ~/.vim/skel/
rsync -avb --backup-dir=~/deployment_backups .vimrc ~/

#install the perl CPAN cusomisations
mkdir -p ~/cpan/CPAN/
rsync -avb --backup-dir=~/deployment_backups .cpan/CPAN/MyConfig.pm ~/cpan/CPAN/
