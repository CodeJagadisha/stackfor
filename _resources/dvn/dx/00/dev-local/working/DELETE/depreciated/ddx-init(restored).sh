#!/bin/bash

# DevenDX Initializer
# v00.01.00.160311
# http://deven.aprettycoolprogram.com
#
# Copyright (C) 2015 A Pretty Cool Program
# http://aprettycoolprogram.com

function AskQuestion(){
	#answer=""
	read -s -n1 -p "$*" answer;
}

function ExitScript(){
	printf "$*"
    exit
}

function FileToString(){
	text=""
	while IFS= read -r fileLine; do
		text+="$fileLine"
	done < "$1"
}

function CreateDirectories(){
	mkdir -p $HOME/Applications/{Atom,Brackets,Eclipse,SublimeText,VSCode}
	mkdir -p $HOME/DevenDX/{Logs,Resources,Scripts,Temporary}
	mkdir $HOME/Documents
	mkdir -p $HOME/Languages/{Ada,Asm,Basic,C,CoffeeScript,Cobol,Cpp,Cs,Dart,Erlang,Fortran,Go,HaskellHTML,Java,Javascript,Lisp,Lua,Objective-C,Perl,PHP,Prolog,Python,R,Ruby,Swift}
	mkdir -p $HOME/Scripts/{sh,batch}
}

function DisableSuggestedPackages() {
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Disable apt-get suggested packages? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		wget -O ~/DevenDX/Resources/apt.conf http://deven.aprettycoolprogram.com/DX/00/packages/apt.conf
		pushd $HOME/DevenDX/Resources
		sudo cp apt.conf /etc/apt/
		popd
	fi
}

function CreateMOTD() {
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Disable apt-get suggested packages? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		wget -O ~/DevenDX/Resources/apt.conf http://deven.aprettycoolprogram.com/DX/00/packages/apt.conf
		pushd $HOME/DevenDX/Resources
		sudo cp apt.conf /etc/apt/
		popd
	fi
}


function InstallPrerequisites() {
	sudo apt-get install dkms build-essential localepurge linux-headers-$(uname -r)
}

function InstallVBoxTools() {
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Install VirtualBox Guest Tools? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		wget -O ~/DevenDX/Resources/VBoxLinuxAdditions.run http://deven.aprettycoolprogram.com/DX/00/packages/VBoxLinuxAdditions.run
		pushd $HOME/DevenDX/Resources
		sudo ./VBoxLinuxAdditions.run
		sudo usermod -a -G vboxsf development
		ln -s /media/sf_Development/ ~/Development
		popd
	fi
}

function InstallCLIOptional(){
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Install optional CLI packages? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		sudo apt-get install emacs zip unzip curl 
	fi
}

function InstallGUI(){
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Install GUI? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		sudo apt-get install xserver-xorg xserver-xorg-core xfonts-base xinit x11-xserver-utils xfce4 xfce4-terminal lightdm lightdm-gtk-greeter
		pushd $HOME/DevenDX/Resources
		sudo ./VBoxLinuxAdditions.run
		popd
	fi
}

function InstallGUIOptional(){
clear
while [[ $answer != [YyNn] ]]; do
	printf "\n"
	AskQuestion "Install optional GUI packages? ${y}Y/N${n} "
done
if [[ $answer = [Yy] ]]; then
	sudo apt-get install iceweasel
fi
}

function InstallPython3(){
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Install Python 3.4.4? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		wget -P $HOME/DevenDX/Temporary http://deven.aprettycoolprogram.com/dx/00/packages/python3.4.4.tgz
		pushd $HOME/DevenDX/Temporary
		tar -xzvf python3-4-3.tar.gz
		./configure
		make
		make test
		make install
		popd
	fi
}

function InstallRVM() {
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Install RVM? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
		\curl -sSL https://get.rvm.io | bash -s stable
	fi
}

function InstallVSCode() {
	clear
	while [[ $answer != [YyNn] ]]; do
		printf "\n"
		AskQuestion "Install Visual Studio Code? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then
		sudo apt-get install libnss3
		wget -P $HOME/DevenDX/Temporary http://deven.aprettycoolprogram.com/dx/00/packages/python3.4.4.tgz
		cp /media/sf_development/Systems/Deven/DX/Applications/VSCode/* /home/development/Applications/VSCode/*
	fi
}

function Cleanup() {
	sudo rm -rf $HOME/DevenDX/Temporary/*
	sudo rm -rf /usr/share/doc/*
	sudo rm -rf /usr/share/man/*
	sudo rm -rf /usr/share/locale/*
	sudo rm /var/cache/apt/archives/*.deb
}

function Refresh() {
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoclean
	sudo apt-get autoremove
	sudo localepurge
}

## MAIN ##

#CreateDirectories
#DisableSuggestedPackages
#CreateMOTD
#InstallPrerequisites
#InstallVBoxTools
#InstallCLIOptional
#InstallGUI
#InstallGUIOptional
#InstallPython3
##InstallPython3Virtualenv
#InstallRVM
##InstallRubyVersion
#InstallVSCode
#Cleanup
#Refresh
#sudo reboot