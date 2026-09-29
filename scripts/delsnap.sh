sudo apt purge snapd -y
sudo cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

sudo apt update

sudo add-apt-repository ppa:mozillateam/ppa

echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

sudo apt-get update

sudo apt install -y firefox qbittorrent ffmpeg kubuntu-restricted-* vlc

sudo apt purge -y elisa haruna kdeconnect kmahjongg kmines kpat ksudoku
sudo apt autoremove -y
sudo apt upgrade -y
