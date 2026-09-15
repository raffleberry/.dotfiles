sudo apt purge -y akregator anthy anthy-common dragonplayer goldendict-ng juk kaddressbook kdeconnect kmail konqueror mozc-utils-gui mozc-server && sudo apt autoremove -y

sudo apt install desktop-file-utils -y

sudo apt update -y && sudo apt upgrade -y

sudo apt install systemd-resolved systemd-timesyncd keepassxc command-not-found vlc qbittorrent -y

sudo systemctl restart systemd-resolved

sudo apt-file update


