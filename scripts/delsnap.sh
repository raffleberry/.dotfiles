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
sudo apt install -y qbittorrent ffmpeg kubuntu-restricted-* vlc

./firefox.sh

sudo apt purge -y elisa haruna kdeconnect kmahjongg kmines kpat ksudoku
sudo apt autoremove -y
sudo apt upgrade -y
