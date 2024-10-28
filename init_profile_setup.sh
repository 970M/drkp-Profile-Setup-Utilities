#!/bin/bash

# ========================================
# Installer polices personnalisées

# cd ~/Téléchargements
# # wget https://github.com/google/fonts/archive/refs/heads/main.zip -O google-fonts.zip
# unzip google-fonts.zip
# cd ~/Téléchargements/fonts-main/

for font in "worksans" "radley" "sourcecodepro"; do
    
    mkdir -p ~/.fonts/$font
    cp fonts-main/ofl/$font/*.otf ~/.fonts/$font/
    echo $font

done



# ========================================
# Installer Chrome
# wget -P ~/Téléchargements https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# sudo apt -f install
