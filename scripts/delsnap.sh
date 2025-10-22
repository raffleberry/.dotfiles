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
sudo cat <<EOF | sudo tee  /etc/apt/preferences.d/firefox-no-snap
Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1
EOF

sudo add-apt-repository ppa:mozillateam/ppa
sudo apt update
sudo apt install firefox -y


sudo apt install -y qbittorrent ffmpeg kubuntu-restricted-* vlc plasma-workspace-wayland stow
