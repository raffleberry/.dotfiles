sudo install -d -m 0755 /etc/apt/keyrings
wget -q "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x738beb9321d1aaec13ea9391aebdf4819be21867" -O- | gpg --dearmor | sudo tee /etc/apt/keyrings/mozilla-ppa.gpg > /dev/null

sudo tee /etc/apt/sources.list.d/mozilla.sources > /dev/null << EOF
Types: deb
URIs: https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu
Suites: resolute
Components: main
Signed-By: /etc/apt/keyrings/mozilla-ppa.gpg
EOF

sudo tee /etc/apt/preferences.d/mozilla > /dev/null << EOF
Package: firefox*
Pin: origin ppa.launchpadcontent.net/mozillateam/ppa/ubuntu
Pin-Priority: 1000
EOF

sudo apt-get update
sudo apt-get install firefox
