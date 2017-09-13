*******************************************************************************
	DevenDX		Version 00.00.00-000000	    deven.aprettycoolprogram.com
*******************************************************************************

DevenDX is Deven for Debian, using xcfe4.

+ Check versions
	Perl (5.2)
	PHP
	GO
	Ruby
	Python (2.7.9)
	Java
	R
+ Test Visual Studio
+ autologin

DevenDX_01.04 (X.XGB)
=============

+ Download and install VSCode
	Download
	unzip VSCode-linux-ia32-stable.zip
	cp -rf VSCode-linux-ia32/* /home/development/Application/VSCode
+ Copied VS code
	mkdir /home/development/Applications/VSCode
	cp /media/sf_development/Systems/Deven/DX/VSCode/* /home/development/Applications/VSCode/

	
	
	

+ Autologin for "development"

+ Setup home folders for host mappings

+ Created "ddxclean.sh" to do cleanups
+ Executed ddxclean.sh
	ddxclean.sh

DevenDX_01.03 (1.3GB)
=============
+ Install iceweasel
	apt-get install iceweasel
+ Install emacs
	apt-get install emacs
+ Install zip/unzip
	sudo apt-get install zip unzip
+ Install libnss3
	sudo apt-get install libnss3
+ Remove everything from /home/development
	rm -rf /home/development/
+ Create symlinks for the sf_ share
	ln -s /media/sf_development/Systems/Deven/DX/Applications /home/development/Applications
	ln -s /media/sf_development/Systems/Deven/DX/Desktop /home/development/Desktop
	ln -s /media/sf_development/Systems/Deven/DX/Documents /home/development/Documents
	ln -s /media/sf_development/Systems/Deven/DX/Downloads /home/development/Downloads
	ln -s /media/sf_development/Systems/Deven/DX/Scripts /home/development/Scripts
+ Update icons in dock
+ Created a MOTD
	sudo nano /etc/motd

DevenDX_01.02 (1.1GB)
=============
+ Disable suggested/recommended packages
	cd /etc/apt
	sudo nano apt.conf
	APT::Install-Recommends "0";
	APT::Install-Suggests "0";
+ Install xserver, and dependencies
	sudo apt-get install xserver-xorg xserver-xorg-core xfonts-base xinit x11-xserver-utils
+ Install xfce4 
	sudo apt-get install xfce4
+ Install lightdm
	sudo apt-get install lightdm lightdm-gtk-greeter
+ Reboot
	sudo reboot
+ Install VirtualBox tools
	sudo apt-get install linux-headers-$(uname -r)
	sudo mount /dev/cdrom /media/cdrom
	cd /media/cdrom
	cp VBoxLinuxAdditions.run /home/development
	sudo ./VBoxLinuxAdditions.run
+ Setup VirtualBox permissions
	sudo usermod -a -G vboxsf <username>
+ Reboot
	sudo rebootsudo 
+ Cleanup some stuff
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoclean
	sudo apt-get autoremove
	sudo localepurge
	sudo dpkg --purge man-db manpages 	
	sudo deborphan | xargs sudo apt-get -y remove --purge	
	sudo rm -rf /usr/share/doc/*
	sudo rm -rf /usr/share/man/*
	sudo rm -rf /usr/share/locale/*
	sudo rm /var/cache/apt/archives/*.deb		
	
DevenDX_01.01 (880MB) --DEPRECIATED
=============
+ Install dkms
	sudo apt-get install dkms
	
DevenDX_01.00 (721MB)
=============
* Install Ubuntu 15.10 using the minimal install CD and VirtualBox
	+ 15GB HDD
	+ 2GB RAM
	+ 128MB VRAM
	+ Installed OpenSSH Server
	+ Installed System Utilities
	+ No additional software installed
+ Install sudo
	su
	apt-get install sudo
+ Add "development" user to sudoers file
	visudo
	Add to end "development ALL=(ALL) NOPASSWD: ALL"
+ Update and upgrade 
	sudo apt-get update
	sudo apt-get dist-upgrade
+ Clean up stuff
	sudo apt-get autoclean
	sudo rm /var/cache/apt/archives/*.deb
+ Install deborphan
	sudo apt-get install deborphan
+ Install dkms
	sudo apt-get install dkms
+ Install and run localepurge
	sudo apt-get install localepurge
+ Delete some stuff
	sudo rm -rf /usr/share/doc/*
	sudo rm -rf /usr/share/man/*
	sudo rm -rf /usr/share/locale/*
+ Run deborphan
	sudo deborphan | xargs sudo apt-get -y remove --purge
+ Purge manpages
	sudo dpkg --purge man-db manpages 
+ Updated and cleaned
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoclean
	sudo apt-get autoremove

		
*******************************************************************************
		
UPDATE&CLEAN SCRIPT
	sudo rm -rf /usr/share/doc/*
	sudo rm -rf /usr/share/man/*
	sudo rm -rf /usr/share/locale/*
	sudo deborphan | xargs sudo apt-get -y remove --purge
	sudo dpkg --purge man-db manpages
	sudo rm /var/cache/apt/archives/*.deb	
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoclean
	sudo apt-get autoremove
		





TECHNOLOGIES TO INCLUDE
=======================

* Python
* Perl
* Ruby
* Java
* GO

* RVM
* PythonEnv

* Apache
* PHP
* MySQL
* MONDO
* PostGRE

* Django
* JBoss
* Jruby
* LAMP
* MEAN
* Nginx
* Node.js
* Ruby on Rails
* Tomcat
* Wildfly
