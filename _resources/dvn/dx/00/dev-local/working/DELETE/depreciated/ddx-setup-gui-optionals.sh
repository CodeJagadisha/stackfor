
#!/bin/bash
# ddx-setup-gui-optionals.sh 00.01.00-160311

# Install GUI apps for xfce4
sudo apt-get install iceweasel

# Cleanup
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/share/locale/*
sudo rm /var/cache/apt/archives/*.deb

# Refresh
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoclean
sudo apt-get autoremove
sudo localepurge