
#!/bin/bash
# ddx-setup-vscode.sh 00.01.00-160311

# Install VSCode prerequisites
sudo apt-get install libnss3

# Copy VSCode to DevenDX
mkdir /home/development/Applications/VSCode
cp /media/sf_development/Systems/Deven/DX/Applications/VSCode/* /home/development/Applications/VSCode/*

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

sudo reboot

cp /media/sf_development/Systems/Deven/DX/Applications/* /home/development/Applications