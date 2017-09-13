#!/bin/bash
# build-dvnbs.sh
# v00.90.00-160320
# This script builds the Deven base. Please see the README.md file for more
# information about this process.

# Text formatting
g=$(tput setaf 2)
c=$(tput setaf 6)
b=$(tput bold)
n=$(tput sgr0)

introMsg="

  ${b}${c}Welcome to the Deven Builder, version .90!${n}

  Please keep in mind that Deven is BETA SOFTWARE! 
  
  Before proceeding, please verify the following:
 
    * You are connected to the internet.
    * You are building Deven in a Debian 8.3.0 environment.
    * You are building Deven in a VirtualBox virtual machine.
    * You have at minimum of 1.1GB of freespace, with additional
      space for any Deven HATS you would like to install.

  The building process will take 25+ minutes, and there may be
  long periods of time where nothing seems to be happening. If
  the installer hangs for longer than 10 minutes, check the log
  files in Deven\Logs, otherwise just be patient.
  
  For more information about these requirements, please visit
  http://deven.aprettycoolprogram.com.\n\n"

choiceMsg="

  ${b}Do you want to:${n}

    ${b}${g}C)${n} Build CLI Deven (requires 1.1GB freespace)
    ${b}${g}G)${n} Build GUI Deven (requires 1.4GB freespace)
    ${b}${g}U)${n} Upgrade CLI Deven to GUI Deven (experimental, requires 300MB)\n\n"
	
reduceVDIMsg="

  Would you like to reduce size of the Deven VDI?

  This process will reduce the size of the Deven VDI on the
  guest. The process takes a long time and, since it involves
  writing a substantial amount of data to disk, it is not
  recommended for use with SSD drives.
  
  In addition to reducing the size of the VDI on the guest,
  you will need to use the VBoxManage utility to reduce the
  size of the VDI on the host. Please see the VirtualBox
  documentation for more information.\n\n"
  
rebootMsg="

  Build complete!

  It is recommended that you reboot your system now.\n\n"

function Introduction() {
    answer=""
    while [[ $answer != [YyNn] ]]; do
        clear
        printf "$introMsg"
        read -s -n 1 -p "  ${b}Proceed? (Y/N): ${n} " answer
    done

    if [[ $answer = [Nn] ]]; then
        printf "\n\n  Exiting builder.\n\n"
        exit $?
    fi
}

function GetBuildType() {
    buildType=""
    while [[ $buildType != [CcGgUu] ]]; do
        clear
        printf "$choiceMsg"
        read -s -n 1 -p "  ${b}Choice? (C/G/U): ${n} " buildType
    done
}

function CreateRequiredDirectories() {
    clear
    printf "\n\n  Creating required directories..." 
    mkdir -p $HOME/Applications
    mkdir -p $HOME/Deven/{Conf,Docs,Logs/Archive,Temp}
    mkdir -p $HOME/Languages
    mkdir -p $HOME/Scripts/{dvn,sh}
    printf "Done." 
}

function SystemRefresh() {
    printf "\n  Refreshing system..." 
    printf "\n    Updating..." 
    sudo apt-get update > $HOME/Deven/Logs/last-update.log.log 2>&1
    printf "Done\n    Upgrading..." 
    sudo apt-get dist-upgrade > $HOME/Deven/Logs/last-upgrade.log 2>&1
    printf "Done\n    Cleaning..." 	
    sudo apt-get autoclean > $HOME/Deven/Logs/last-autoclean.log 2>&1
    printf "Done\n    Removing..."  	
    sudo apt-get autoremove > $HOME/Deven/Logs/last-autoremove.log 2>&1
    printf "Done." 
}

function DisableSuggestedPackages() {
    printf "\n  Disabling apt-get suggested package installs..." 
    sudo sh -c 'echo "APT::Install-Recommends "0";\nAPT::Install-Suggests "0";" >> /etc/apt/apt.conf'
    printf "Done." 
}

function InstallLocalepurge(){
    clear
    printf "\n  Installing and configuring localepurge...\n  This is interactive, and a bit ugly...\n\n" 
    sudo apt-get install -y localepurge |& tee $HOME/Deven/Logs/install-localepurge.log
    printf "\n\nDone."
    clear
}

function InstallRequiredPackages() {
    printf "\n  Installing required packages..."
    printf "\n    bzip2..."
    sudo apt-get install -y bzip2 > $HOME/Deven/Logs/install-required-packages.log 2>&1
    printf "Done.\n    dkms..." 
    sudo apt-get install -y dkms >> $HOME/Deven/Logs/install-required-packages.log 2>&1
    printf "Done.\n    python3..."
    sudo apt-get install -y python3 >> $HOME/Deven/Logs/install-required-packages.log 2>&1
    printf "Done.\n    linux headers..."
    sudo apt-get install -y linux-headers-$(uname -r) >> $HOME/Deven/Logs/install-required-packages.log 2>&1
    printf "Done."
}

function InstallGUI() {
    printf "\n  Installing GUI packages..."
    printf "\n    xorg..."
    sudo apt-get install -y xorg > $HOME/Deven/Logs/build-gui.log 2>&1
    printf "Done.\n    xfce4..." 
    sudo apt-get install -y xfce4 >> $HOME/Deven/Logs/build-gui.log 2>&1
    printf "Done.\n    tango-icon-theme..."     
    sudo apt-get install -y tango-icon-theme >> $HOME/Deven/Logs/build-gui.log 2>&1    
    printf "Done." 
}

function InstallVBoxTools() {
    printf "\n  Installing VirtualBox Guest Tools..."
    printf "\n    Downloading..."
    wget -O $HOME/Deven/Temp/VBoxLinuxAdditions.run http://deven.aprettycoolprogram.com/dx/00/bld/rsrc/VBoxLinuxAdditions-5.0.16.run > $HOME/Deven/Logs/installvboxtools.log 2>&1
    pushd $HOME/Deven/Temp >> $HOME/Deven/Logs/installvboxtools.log 2>&1
    printf "Done.\n    Installing tools...this may take a while..."
    chmod +x VBoxLinuxAdditions.run >> $HOME/Deven/Logs/installvboxtools.log 2>&1
    sudo ./VBoxLinuxAdditions.run >> $HOME/Deven/Logs/installvboxtools.log 2>&1
    popd >> $HOME/Deven/Logs/installvboxtools.log 2>&1
    printf "Done." 
}

function SetupVBoxSharing() {
    printf "\n  Setting up VirtualBox file sharing..." 
    sudo usermod -a -G vboxsf deven
    ln -s /media/sf_HostShare/ $HOME/Development
    printf "Done." 
}

function UpdateBashProfile() {
    printf "\n  Updating Bash profile..." 
    echo "
PATH=\"\$HOME/Scripts:\$PATH\"" >> $HOME/.profile
    printf "Done." 
}

function DownloadDevenDocs() {
    printf "\n  Downloading Deven documentation..." 
    wget -O $HOME/Deven/Temp/motd http://deven.aprettycoolprogram.com/dx/00/bld/rsrc/motd-00.90.00 > $HOME/Deven/Logs/download-documentation.log 2>&1
    sudo cp $HOME/Deven/Temp/motd /etc/motd >> $HOME/Deven/Logs/documentation.log 2>&1
    wget -O $HOME/Deven/Docs/README.md http://deven.aprettycoolprogram.com/dx/00/doc/README.md >> $HOME/Deven/Logs/download-documentation.log 2>&1
    wget -O $HOME/Deven/Docs/LICENSE.md http://deven.aprettycoolprogram.com/dx/00/doc/LICENSE.md >> $HOME/Deven/Logs/download-documentation.log 2>&1
    wget -O $HOME/Deven/Docs/CHANGELOG.md http://deven.aprettycoolprogram.com/dx/00/doc/CHANGELOG.md >> $HOME/Deven/Logs/download-documentation.log 2>&1
    printf "Done." 
}

function DownloadDevenPy() {
    printf "\n  Downloading and unpacking Devenpy..." 
    wget -O $HOME/Deven/Temp/dvnpy.tar.gz http://deven.aprettycoolprogram.com/dx/00/dvn/rls/dvnpy.tar.gz > $HOME/Deven/Logs/dvnpy.log 2>&1
    tar -xzf $HOME/Deven/Temp/dvnpy.tar.gz -C $HOME/Scripts/dvn >> $HOME/Deven/Logs/dvnpy.log 2>&1
    printf "Done." 
}

function DownloadEnvironmentScripts() {
    printf "\n  Downloading environment scripts..." 
    wget -O $HOME/Scripts/sh/dvnbk.sh http://deven.aprettycoolprogram.com/dx/00/sh/dvnbk.sh > $HOME/Deven/Logs/environment-scripts.log 2>&1
}

function WriteDevenInfo() {
    printf "\n  Writing Deven information to system..."
    touch $HOME/Deven/Conf/deven.version
    echo "00.90.00" > $HOME/Deven/Conf/deven.version
    touch $HOME/Deven/Conf/deven.build
    echo "160320" > $HOME/Deven/Conf/deven.build 
    printf "Done." 
}

function Cleanup() {
    printf "\n  Cleaning up...\n    Removing standard directories..."
    sudo rm $HOME/Music/ $HOME/Pictures/ $HOME/Public/ $HOME/Templates/ $HOME/Videos/ > $HOME/Deven/Logs/remove-data.log 2>&1	
    printf "Done.\n    Removing system documentation..." 
    sudo rm -rf /usr/share/doc/*
    sudo rm -rf /usr/share/man/*
    sudo rm -rf /usr/share/locale/*
    printf "Done.\n    Removing package archives..." 
    if test -f "/var/cache/apt/archives/*.deb"; then
        sudo rm /var/cache/apt/archives/*.deb;
    fi
    printf "Done.\n    Removing temporary files..." 
    sudo rm -rf $HOME/Deven/Temp/*
    printf "Done.\n    Removing home directory straglers..." 
    rm * >> $HOME/Deven/Logs/remove-data.log 2>&1	
    printf "Done.\n    Compressing log files..." 
    DATE=$(date +"%Y%m%d%H%M")
    tar -czvf $HOME/Deven/Logs/Archive/build-$DATE.tar.gz -C $HOME/Deven/Logs/* > $HOME/Deven/Logs/archive-logs.log 2>&1
    rm $HOME/Deven/Logs/*.log
    printf "Done."
}

function ReduceVDI() {
    answer=""
    while [[ $answer != [YyNn] ]]; do
        clear
        printf "$reduceVDIMsg"
        read -s -n 1 -p "  ${b}Reduce the VDI? (Y/N): ${n} " answer
    done
  
    if [[ $answer = [Yy] ]]; then
        printf "\n\n  Reducing image size. Please be patient...\n"
        sudo dd if=/dev/zero of=$HOME/reducer bs=4096k
        sudo rm -rf $HOME/reducer
        printf "Done." 
    fi
}

function ClearBashHistory() {
    printf "\n  Clearing Bash history..."
    history -c # This doesn't actually work!
    printf "Done." 
}

function RebootSystem() {
    answer=""
    while [[ $answer != [YyNn] ]]; do
        clear
        printf "$rebootMsg"
        read -s -n 1 -p "  ${b}Reboot? (Y/N): ${n} " answer
    done
  
    if [[ $answer = [Yy] ]]; then
        sudo reboot
    elif [[ $answer = [Nn] ]]; then
        printf "\n\n  Bye!\n\n"
    fi
}

Introduction
GetBuildType

if [[ $buildType = [Cc] ]]; then   # CLI
    CreateRequiredDirectories
    DisableSuggestedPackages
    SystemRefresh
    InstallLocalepurge
    InstallRequiredPackages
    InstallVBoxTools
    SetupVBoxSharing
    UpdateBashProfile
    DownloadDevenDocs
    DownloadDevenPy
    DownloadEnvironmentScripts
    WriteDevenInfo
    SystemRefresh
    Cleanup
    ReduceVDI
    ClearBashHistory 
elif [[ $buildType = [Gg] ]]; then #GUI  
    CreateRequiredDirectories
    DisableSuggestedPackages
    SystemRefresh
    InstallLocalepurge
    InstallRequiredPackages
    InstallGUI
    InstallVBoxTools
    SetupVBoxSharing
    UpdateBashProfile
    DownloadDevenDocs
    DownloadDevenPy
    DownloadEnvironmentScripts
    WriteDevenInfo
    SystemRefresh
    Cleanup
    ReduceVDI
    ClearBashHistory     
elif [[ $buildType = [Uu] ]]; then # Upgrade to GUI
    SystemRefresh
    InstallGUI
    InstallVBoxTools
    Cleanup
fi

RebootSystem
