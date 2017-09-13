#!/bin/bash
# ddx-install-python3.sh 00.00.00-160311

# Install Python 3.4.4
mkdir /home/development/Languages/Python3/
wget -O ~/Languages/Python3/python3.tgz https://www.python.org/ftp/python/3.4.4/Python-3.4.4.tgz
cd /home/development/Languages/Python3/
tar -xzfv python3.tgz
./configure
make
make test
sudo make install

### INSTALL VIRTUALENV

# Refresh
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoclean
sudo apt-get autoremove
sudo localepurge
sudo rm -rf /usr/share/doc/*
sudo rm -rf /usr/share/man/*
sudo rm -rf /usr/share/locale/*
sudo rm /var/cache/apt/archives/*.deb	