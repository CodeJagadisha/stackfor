
#!/bin/bash
# ddx-setup-gui.sh 00.01.00-160311

# Install GUI requirements and xfce4
sudo apt-get install xserver-xorg xserver-xorg-core xfonts-base xinit x11-xserver-utils xfce4 xfce4-terminal lightdm lightdm-gtk-greeter

# Reinstall VirtualBox tools
cd /home/development/DevenDX/Resources
unzip VBoxLinuxAdditions.run.zip
sudo ./VBoxLinuxAdditions.run

# Cleanup
## Zip up VBtools
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