#!/bin/bash
# DevenDX Builder - v00.90.00.160314 - http://deven.aprettycoolprogram.com

# Create Deven directories
mkdir ~/Applications
mkdir ~/Documents
mkdir ~/Languages
mkdir ~/Scripts
mkdir -p ~/Deven/{Docs,Logs,Temp}

# Disable suggested and recommended apt-get packages
wget -O ~/Deven/Temp/apt.conf http://aprettycoolprogram.com/deven/00/packages/apt.conf |& tee ~/Deven/Logs/apt-disablesuggested.log
sudo cp ~/Deven/Temp/apt.conf /etc/apt/

# Install basic packages
sudo apt-get install -y dkms build-essential localepurge openssh-server xorg xfce4 xfce4-terminal iceweasel linux-headers-$(uname -r) |& tee ~/Deven/Logs/required-packages.log

# Install VirtualBox Guest Tools
wget -O ~/VBoxLinuxAdditions.run http://aprettycoolprogram.com/deven/00/packages/VBoxLinuxAdditions-5.0.16.run
chmod +x VBoxLinuxAdditions.run
sudo ./VBoxLinuxAdditions.run |& tee ~/Deven/Logs/installVBTools.log

# Create symbolic link to host directory
sudo usermod -a -G vboxsf development
ln -s /media/sf_Development/ ~/Development

# Install Python3
sudo apt-get install -y python3 python3-dev |& tee ~/Deven/Logs/installpython3.log

# Get documentation
wget -O ~/Deven/Temp/motd http://aprettycoolprogram.com/deven/00/dl/motd
sudo cp ~/Deven/Temp/motd /etc/motd
wget -O ~/Deven/Docs/README.md http://aprettycoolprogram.com/deven/00/documentation/README.md
wget -O ~/Deven/Docs/LICENSE.md http://aprettycoolprogram.com/deven/00/documentation/LICENSE.md
wget -O ~/Deven/Docs/CHANGELOG.md http://aprettycoolprogram.com/deven/00/documentation/CHANGELOG.md

# Add scripts directory to PATH (make permenant!)
export PATH=$PATH:~/Scripts

# Cleanup
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/share/locale/*
sudo rm /var/cache/apt/archives/*.deb
sudo rm ~/build.sh
sudo rm -rf ~/Deven/Temp/*
sudo rm -rf ~/Music/
sudo rm -rf ~/Pictures/
sudo rm -rf ~/Public/
sudo rm -rf ~/Templates/
sudo rm -rf ~/Videos/
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoclean
sudo apt-get autoremove
sudo localepurge
sudo reboot