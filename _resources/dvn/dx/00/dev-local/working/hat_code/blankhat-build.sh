#!/bin/bash
# blankhat-build.sh
# v00.90.00-160318
# This script will build the blank hat.





# Build prerequisites
function BuildPrerequisites()
{
	# Create Deven directories needed for building
	mkdir -p $HOME/Deven/{Docs,Logs}

	# Disable suggested and recommended apt-get packages
	wget -O $HOME/Deven/Temp/apt.conf http://aprettycoolprogram.com/deven/dx/00/build/apt.conf
	sudo mv $HOME/Deven/Temp/apt.conf /etc/apt/

	# Update and upgrade
	sudo apt-get update
	sudo apt-get dist-upgrade
}

# Build base
function BuildBase()
{
	# Install the rest of the required packages
	sudo apt-get install -y dkms build-essential python3-dev linux-headers-$(uname -r) |& tee $HOME/Deven/Logs/buildbase.log
}

# Build GUI
function BuildGUI()
{
	while [[ $answer != [YySs] ]]; do
		clear
		PromptUser "  ${bold}Would you like to build the Deven GUI? ([Y]es/[S]kip):${normal} "
	done

	if [[ $answer = [Yy] ]]; then
		# Install the rest of the required packages
		sudo apt-get install -y xorg xfce4 tango-icon-theme |& tee $HOME/Deven/Logs/buildgui.log
 	fi
}

function BuildTools()
{
	# Install VirtualBox Guest Tools
	wget -O $HOME/Deven/Temp/VBoxLinuxAdditions.run http://aprettycoolprogram.com/deven/dx/00/packages/VBoxLinuxAdditions-5.0.16.run
	pushd $HOME/Deven/Temp
	chmod +x VBoxLinuxAdditions.run
	sudo ./VBoxLinuxAdditions.run |& tee $HOME/Deven/Logs/buildvbtools-base.log
	popd
	
	# Add deven user to VirtualBox host sharing group
	sudo usermod -a -G vboxsf deven
}

# Build structure
function BuildStructure()
{
  # Create Deven directories
	mkdir -p $HOME/Applications/{Atom,Brackets,Eclipse,SublimeText,VSCode}
	mkdir -p $HOME/Languages/{Cpp,Cs,CSS,Go,HTML,Java,Javascript,Perl,PHP,Python,R,Ruby,Swift}
	mkdir -p $HOME/Scripts/{sh,batch}
  
	# Create symbolic link to host directory
	ln -s /media/sf_Development/ $HOME/Development
	
	# Add scripts directory to PATH via .profile - Depreciated?
	# wget -O $HOME/.profile http://aprettycoolprogram.com/deven/dx/00/build/bash_profile
  echo "PATH=\"\$HOME/Scripts:\$PATH\""
}

# Finalize build
function BuildFinalize()
{
	# Get documentation
	wget -O $HOME/Deven/Temp/motd http://aprettycoolprogram.com/deven/dx/00/build/motd
	sudo cp $HOME/Deven/Temp/motd /etc/motd
	wget -O $HOME/Deven/Docs/README.md http://aprettycoolprogram.com/deven/dx/00/docs/README.md
	wget -O $HOME/Deven/Docs/LICENSE.md http://aprettycoolprogram.com/deven/dx/00/docs/LICENSE.md
	wget -O $HOME/Deven/Docs/CHANGELOG.md http://aprettycoolprogram.com/deven/dx/00/docs/CHANGELOG.md
	
  # Remove standard user directories
	sudo rm $HOME/Music/ $HOME/Pictures/ $HOME/Public/ $HOME/Templates/ $HOME/Videos/
  
	# Cleanup
	sudo rm -rf /usr/share/doc/*
	sudo rm -rf /usr/share/man/*
	sudo rm -rf /usr/share/locale/*
	sudo rm /var/cache/apt/archives/*.deb
	sudo rm $HOME/deven*.sh
	sudo rm -rf $HOME/Deven/Temp/*
	
	# Refresh
	sudo apt-get update
	sudo apt-get dist-upgrade
	sudo apt-get autoclean
	sudo apt-get autoremove
	sudo localepurge
}

# Done
function BuildDone()
{
  while [[ $answer != [YyEe] ]]; do
    clear
    printf "$buildcompleteMsg"
    PromptUser "  ${bold}  \n\n  Deven has been built! Reboot? ([Y]es/[N]o):${normal} "
  done
  
  if [[ $answer = [Yy] ]]; then
    sudo reboot
  elif [[ $answer = [Nn] ]]; then
    printf "\n\n${bold}\n\n  Exiting builder...${normal}\n\n\n\n"
    exit $?
  fi
}

Introduction
BuildPrerequisites
BuildBase
BuildGUI
BuildTools
BuildStructure
#GetDevenPy
BuildFinalize
BuildDone