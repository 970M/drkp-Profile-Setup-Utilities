#!/bin/bash

#_____ [[ PERSONALISATION BASHRC ]] _________________________________

mkdir -p ~/.bashrc.d/

echo `pwd`

cp ../conf/gd_alias.bashrc ~/.bashrc.d/

cat <<EOF >> ~/.bashrc
# Source all .bashrc files in
for file in ~/.bashrc.d/*.bashrc; do
	. "$file"
done

EOF

#_____ [[ MAJ DES PACKAGES ]] _______________________________________

sudo apt-get update && sudo apt-get dist-upgrade

#_____ [[ INSTALLATION DES PROGRAMMES ]] ____________________________
#
# >> A partir des Dépots:
# sudo apt install program1 program2 program3 -y
#
# >> A partir de Logitheque ubuntu :
# sudo snap install snappackage1 snappackage2 snappackage3


##### Utilitaires ######

##### Développement ####

# VSCode
sudo snap install --classic code

# ATOM #
# ajouter une entrée aux sources
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update
#Installer
sudo apt-get install atom   
# Packages
apm install platformio-ide-terminal 
apm install atom-ide-base
apm install ide-python

##### Internet #########

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -f install

##### Jeux #############

##### Multimédia #######

sudo snap install vlc # VLC

##### Productivité #####
