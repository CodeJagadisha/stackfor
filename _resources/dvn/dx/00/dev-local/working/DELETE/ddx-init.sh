#!/bin/bash

# DevenDX Initializer
# v00.01.00.160311
# http://deven.aprettycoolprogram.com
#
# Copyright (C) 2015 A Pretty Cool Program
# http://aprettycoolprogram.com

disableSuggestedPackages="false"
createMOTD="false"
installVBoxTools="false"
installCLIOptional="false"
installGUI="false"
installGUIOptional="false"
installPython3="false"
installVirtualenv="false"
installRVM="false"
installVSCode="false"

function ResetAnswer() {
	answer=""
}

function AskQuestion() {
	read -s -n1 -p "$*" answer;
}

function ExitScript() {
	printf "$*"
    exit
}

function FileToString(){
	text=""
	while IFS= read -r fileLine; do
		text+="$fileLine"
	done < "$1"
}

GetManifestFromUser() {
	clear
	printf "\n"
	printf "Welcome to the DevenDX Initialization Script."
	printf "\n"

	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Disable apt-get suggested packages? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then disableSuggestedPackages="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Create a Message of the Day (MOTD)? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then CreateMOTD="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install VirtualBox Guest Tools? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installVBoxTools="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install optional CLI packages? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installCLIOptional="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install GUI? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installGUI="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install optional GUI packages? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installGUIOptional="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install Python3? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installPython3="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install Virtualenv? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installVirtualenv="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install Ruby Version Manager (RVM)? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installRVM="true"; fi
	
	ResetAnswer
	while [[ $answer != [YyNn] ]]; do
		printf "\n"; AskQuestion "Install Visual Studio Code? ${y}Y/N${n} "
	done
	if [[ $answer = [Yy] ]]; then installVSCode="true"; fi
}

function CreateDirectories(){
	clear
	mkdir -p $HOME/Applications/{Atom,Brackets,Eclipse,SublimeText,VSCode}
	mkdir -p $HOME/DevenDX/{Logs,Resources,Scripts,Temporary}
	mkdir $HOME/Documents
	mkdir -p $HOME/Languages/{Ada,Asm,Basic,C,CoffeeScript,Cobol,Cpp,Cs,Dart,Erlang,Fortran,Go,Haskell,HTML,Java,Javascript,Lisp,Lua,Objective-C,Perl,PHP,Prolog,Python,R,Ruby,Swift}
	mkdir -p $HOME/Scripts/{sh,batch}
}

function DisableSuggestedPackages() {
	clear
	wget -O ~/DevenDX/Resources/apt.conf http://aprettycoolprogram.com/deven/dx/00/packages/apt.conf |& tee $HOME/DevenDX/Logs/apt-disablesuggested.log
	pushd $HOME/DevenDX/Resources
	sudo cp apt.conf /etc/apt/
}

function CreateMOTD() {
	clear
	wget -O ~/DevenDX/Resources/motd http://aprettycoolprogram.com/deven/dx/00/packages/motd |& tee $HOME/DevenDX/Logs/motd.log
	pushd $HOME/DevenDX/Resources
	sudo cp motd /etc/motd
	popd
}

function InstallPrerequisites() {
	clear
	# don't prompt
	sudo apt-get install -y dkms build-essential localepurge linux-headers-$(uname -r) |& tee $HOME/DevenDX/Logs/prerequisites.log
}

function InstallVBoxTools() {
	clear
	wget -O ~/DevenDX/Resources/VBoxLinuxAdditions.run http://aprettycoolprogram.com/deven/dx/00/packages/VBoxLinuxAdditions.run |& tee $HOME/DevenDX/Logs/vbox-tools.log
	pushd $HOME/DevenDX/Resources
	chmod +x VBoxLinuxAdditions.run
	sudo ./VBoxLinuxAdditions.run
	sudo usermod -a -G vboxsf development
	ln -s /media/sf_Development/ ~/Development
}

function InstallCLIOptional(){
	clear
	sudo apt-get install -y emacs zip unzip curl |& tee $HOME/DevenDX/Logs/cli-optional.log
}

function InstallGUI(){
	clear
	sudo apt-get install -y xserver-xorg xserver-xorg-core xfonts-base xinit x11-xserver-utils xfce4 xfce4-terminal lightdm lightdm-gtk-greeter |& tee $HOME/DevenDX/Logs/gui-install.log
	pushd $HOME/DevenDX/Resources
	sudo ./VBoxLinuxAdditions.run
	popd

}

function InstallGUIOptional(){
	clear
	sudo apt-get install -y iceweasel |& tee $HOME/DevenDX/Logs/gui-optional.log
}

function InstallPython3(){
	clear
	sudo apt-get install -y python3 python3-dev |& tee $HOME/DevenDX/Logs/python3.log
}

function InstallRVM() {
	clear
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 |& tee $HOME/DevenDX/Logs/rvm-gpg.log
	\curl -sSL https://get.rvm.io | bash -s stable |& tee $HOME/DevenDX/Logs/rvm-install.log

}

function InstallVSCode() {
	clear
	sudo apt-get install libnss3
	wget -P $HOME/DevenDX/Applications/VSCode http://aprettycoolprogram.com/deven/dx/00/packages/vscode.tar
	cd $HOME/DevenDX/Applications/VSCode
	tar -xvf vscode.tar |& tee $HOME/DevenDX/Logs/untar-vscode.log
	cd
}

function Cleanup() {
	clear
	sudo rm -rf $HOME/DevenDX/Temporary/*
	sudo rm -rf /usr/share/doc/*
	sudo rm -rf /usr/share/man/*
	sudo rm -rf /usr/share/locale/*
	sudo rm /var/cache/apt/archives/*.deb
}

function Refresh() {
	clear
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoclean
	sudo apt-get autoremove
	sudo localepurge
}

## MAIN ##


GetManifestFromUser
CreateDirectories

if [ $disableSuggestedPackages = "true" ]; then DisableSuggestedPackages; fi

InstallPrerequisites

if [ $installVBoxTools = "true" ]; then InstallVBoxTools; fi
if [ $installCLIOptional = "true" ]; then InstallCLIOptional; fi
if [ $installGUI = "true" ]; then InstallGUI; fi
if [ $installGUIOptional = "true" ]; then InstallGUIOptional; fi
if [ $installPython3 = "true" ]; then InstallPython3; fi
#if [ $installVirtualenv = "true" ]; then InstallVirtualEnv; fi
#if [ $installRVM = "true" ]; then InstallRVM; fi
#if [ $installVSCode = "true" ]; then InstallVSCode; fi
if [ $createMOTD = "true" ]; then CreateMOTD; fi
Cleanup
Refresh
#sudo reboot




# Add Scripts/ to path
# Script for installing ruby versions
# Script for installing Python versions
