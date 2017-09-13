
#!/bin/bash
# ddx-setup-base.sh 00.01.00-160311

# Install base packages
sudo apt-get install dkms build-essential localepurge linux-headers-$(uname -r)

# Create base directories
mkdir /home/development/Applications
mkdir /home/development/DevenDX
mkdir /home/development/Documents
mkdir /home/development/Languages
mkdir /home/development/Scripts

# Cleanup
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/share/locale/*
sudo rm /var/cache/apt/archives/*.deb
sudo rm /home/development/ddx-setup-base.sh

# Refresh
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoclean
sudo apt-get autoremove
sudo localepurge