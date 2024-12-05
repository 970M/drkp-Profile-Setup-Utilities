#!/bin/bash


# ========================================
# Installer Firefox sans snap
# https://support.mozilla.org/fr/kb/installer-firefox-linux#w_installation-de-firefox-avec-les-binaires-de-mozilla
sudo snap remove firefox
sudo apt-get remove firefox
sudo apt-get update
wget -q -O firefox.tar.bz2 https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=fr
tar xjf firefox-*.tar.bz2
sudo mv firefox /opt
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications
cd /etc/apparmor.d/
touch firefox-local

sudo echo '
# Ce profil autorise tout et n’existe que pour donner à
# l’application un nom plutôt que laisser l’étiquette "unconfined"
abi <abi/4.0>,
include <tunables/global>
profile firefox-local
/home/<USER>/bin/firefox/{firefox,firefox-bin,updater}
flags=(unconfined) {
    userns,
    # Ajouts propres à l’installation et surcharges.
    # Consultez local/README pour des précisions.
    include if exists <local/firefox>
}' | sudo tee /etc/apparmor.d/firefox-local

sudo systemctl restart apparmor.service


# ========================================
# Installer polices personnalisées

# cd ~/Téléchargements
# # wget https://github.com/google/fonts/archive/refs/heads/main.zip -O google-fonts.zip
# unzip google-fonts.zip
# cd ~/Téléchargements/fonts-main/

# for font in "worksans" "radley" "sourcecodepro"; do
    
#     mkdir -p ~/.fonts/$font
#     cp fonts-main/ofl/$font/*.otf ~/.fonts/$font/
#     echo $font

# done



# ========================================
# Installer Chrome
# wget -P ~/Téléchargements https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# sudo apt -f install
