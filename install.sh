#!/bin/bash

# To install the zenity package if its not installed
if ! command -v zenity &>/dev/null; then
    echo "Installing zenity..."
    sudo apt install -y zenity
fi

sudo mkdir -p /opt/MusicPlayer
cp musicPlayer.sh /opt/MusicPlayer
sudo ln -s /opt/MusicPlayer/musicPlayer.sh  /usr/local/bin/musicPlayer
chmod +x /opt/MusicPlayer/musicPlayer.sh  
