#!/bin/bash
set -euo pipefail
# install packages
sudo apt-get install rclone dislocker ecryptfs-utils cryptsetup curl git git-man pwgen tree atop
sudo snap install docker
# lenovo specific stuff if not already installed.
sudo ubuntu-drivers install lenovo-doc-addison-p15vg1-t15pg1
# install 1password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo apt-key add -
echo 'deb [arch=amd64] https://downloads.1password.com/linux/debian/amd64 beta main' | sudo tee /etc/apt/sources.list.d/1password-beta.list
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
sudo apt update && sudo apt install 1password
# download 1password command line tool from https://app-updates.agilebits.com/product_history/CLI
gpg --keyserver hkps://keyserver.ubuntu.com  --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
gpg --verify ~/Dowloads/op.sig ~/Dowloads/op
mkdir ~/bin/
cp ~/Dowloads/op ~/bin/
cp ~/Dowloads/op.sig ~/bin/
#add to .bashrc
cat >> ~/.bashrc <<EOL
#john additions
alias pym='python3 manage.py'
alias mkenv='python3 -m venv env'
alias startenv='source env/bin/activate && which python3'
alias stopenv='deactivate'
export PATH=$PATH:~/bin/
eval $(op signin my)
EOL
# setup 1password command line
op signin https://my.1password.com john@kript.net

#eval $(op signin my)
# docs: https://support.1password.com/command-line-getting-started/

# docker setup stuff
portainer_admin=$(pwgen 8 1)
echo $portainer_admin > ~/.portainer_admin
echo $portainer_admin > /tmp/portainer_password

docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

$ docker run -d -p 9000:9000 -p 8000:8000 -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/portainer_password:/tmp/portainer_password portainer/portainer --admin-password-file /tmp/portainer_password
# setup ssh
ssh-keygen
ssh-add
# setup git repos
mkdir -p ~/code
#for d in $(cat repos.txt | cut -d: -f2 | cut -d/ -f1); do mkdir -p ~/code/github/"${d}"; done
awk -F'\/|(\.git)' '{system( "cd ~/code/ && git clone " $0)}' repos.txt


