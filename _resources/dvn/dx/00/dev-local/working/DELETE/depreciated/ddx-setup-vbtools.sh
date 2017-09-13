
#!/bin/bash
# ddx-setup-base.sh 00.01.00-160311

# Install base packages
sudo apt-get install zip unzip

# Install VirtualBox tools
mkdir /home/development/DevenDX/Resources
wget -O ~/DevenDX/Resources/VBoxLinuxAdditions.run http://ddx.aprettycoolprogram.com/00/packages/VBoxLinuxAdditions.run]
cd /home/development/DevenDX/Resources
sudo ./VBoxLinuxAdditions.run
sudo usermod -a -G vboxsf development

# Cleanup
## Zip up VBtools
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/share/locale/*
sudo rm /var/cache/apt/archives/*.deb
sudo rm /home/development/ddx-setup-vbtools.sh

# Refresh
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoclean
sudo apt-get autoremove
sudo localepurge

#sudo reboot