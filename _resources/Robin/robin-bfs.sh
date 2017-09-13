#!/bin/bash

#  PROJECT: RobinLinux
# FILENAME: robin-bfs.sh
#    BUILD: 170405
#
# Copyright 2017 A Pretty Cool Program
#
# Robin is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
#
# For more information about pie, please visit http://aprettycoolprogram.com/robinlinux.

## This script will start building Robin Linux from scratch
## <MORE>
##

## SETUP ---------------------------------------------------------------------------------------------------------------




## TEXT FORMATTING -----------------------------------------------------------------------------------------------------

# Foreground colors
export fB=$(tput setaf 0);  export fR=$(tput setaf 1);  export fG=$(tput setaf 2);  export fY=$(tput setaf 3);
export fU=$(tput setaf 4);  export fM=$(tput setaf 5);  export fC=$(tput setaf 6);  export fW=$(tput setaf 7);
# Background colors
export bB=$(tput setab 0);  export bR=$(tput setab 1);  export bG=$(tput setab 2);  export bY=$(tput setab 3);
export bU=$(tput setab 4);  export bM=$(tput setab 5);  export bC=$(tput setab 6);  export bW=$(tput setab 7);
# Others
export tH=$(tput smso);     export th=$(tput rmso);     export tU=$(tput smul);     export tu=$(tput rmul);
export tB=$(tput bold);     export tV=$(tput rev);      export tD=$(tput dim);      export tL=$(tput blink);
export tR=$(tput sgr0);

## MESSAGES ------------------------------------------------------------------------------------------------------------



stepOneMsg="

${b}${c}  STEP ONE: Prepare host system${n}

  If you are using a VirtualBox image to build Robin, it's
  recommended that you do a few things to prepare your
  system. The following step will:

    * Update and upgrade the system
    * Install the VirtualBox Guest VBoxGuestAdditions
    * Setup VirtualBox file sharing

  After this step has been completed, the system will
  reboot, and building Robin Linux will continue.

  If your system meets the above requirements, you can
  skip this step.

"

stepTwoMsg="

${b}${c}  STEP TWO: Confirm host development tools${n}

  Next we will check your host OS to make sure it has
  the following development tools that are required
  to build Robin Linux:
  
    Bash            Gawk                    Make
    Binutils        GCC (including g++)     Patch
    Bison           Glibc                   Perl
    Bzip2           Grep                    Sed
    Coreutils       Gzip                    Tar
    Diffutils       Linux Kernel            Texinfo
    Findutils       M4                      Xz
    
  You will be notified if you are missing any of the
  above tools, or if the installed version is not
  compatible with Linux From Scratch.

"

## COMMON FUNCTIONS  ---------------------------------------------------------------------------------------------------

# Pass this a question, get an answer.
function GetAnswer()
{
	read -s -n1 -p "$*" answer;
}

# Exit the script with a custom message.
function ExitScript()
{
	printf "$*"
    exit
}

# Setup a few things for Robin-bfs.
function RobinBFSSetup()
{
    mkdir -p $HOME/.robin/{logs,temp}
    date=$(date +"%Y-%m-%d-%H-%M")
    buildVersion="170405"
    logfile="$HOME/.robin/robin-bfs-$buildVersion-$date.log"
}

## BUILD STEPS  ----------------------------------------------------------------------------------------------------

# Display welcome message, and make sure the user wants to continue.
function WelcomeMessage()
{
    clear
    printf "$welcomeMsg"

    answer=""
    while [[ $answer != [YyNn] ]]; do
        GetAnswer "Would you like to continue? ${y}Y/N${n} "
    done

    if [[ $answer = [Nn] ]]; then
        ExitScript "Exiting script.\n\n"
    fi
    # Since [Yy] means continue, we won't have logic here.
}

# STEP ONE: Prepare for the build.
function StepOne()
{
    clear
    printf "$stepOneMsg"

    answer=""
    while [[ $answer != [YyNn] ]]; do
        GetAnswer "Would you like to continue? ${y}Y/N${n} "
    done

    if [[ $answer = [Yy] ]]; then
        clear
        printf "\n%2sSTEP ONE: Preparing host system..."
        printf "\n%4sUpdating system..."
        sudo apt-get update > "$logfile" 2>&1
        printf "complete.\n%4sUpgrading system..."
        sudo apt-get upgrade >> "$logfile" 2>&1
        printf "complete.\n%4sUpgrading distribution..."
        sudo apt-get dist-upgrade >> "$logfile" 2>&1
        printf "complete.\n%4sInstalling bzip2..."
        sudo apt-get install bzip2
        printf "complete.\n%4sInstalling gcc..."
        sudo apt-get install gcc
        printf "complete.\n%4sInstalling make..."
        sudo apt-get install make
        printf "complete.\n%4sInstalling curl..."
        sudo apt-get install curl
        printf "complete.\n%4sInstalling linux-headers..."
        sudo apt-get install linux-headers-$(uname -r)
        printf "complete.\n%4sInstalling linux-headers..."
        sudo apt-get install linux-headers-$(uname -r)
        printf "complete.\n%2sDownloading VirtualBox Guest Additions..."
        wget -P $HOME/.crispy/temp http://download.virtualbox.org/virtualbox/5.1.18/VBoxGuestAdditions_5.1.18.iso >> "$logfile" 2>&1
        printf "complete.\n%4sMounting image..."
        sudo mount $HOME/.crispy/temp/VBoxGuestAdditions_5.1.18.iso /media/cdrom >> "$logfile" 2>&1
        printf "complete.\n%4sCopying files..."
        cp /media/cdrom/VBoxLinuxAdditions.run $HOME/.crispy/temp/ >> "$logfile" 2>&1
        printf "complete.\n%4sExecuting script..."
        sudo $HOME/.crispy/temp/VBoxLinuxAdditions.run >> "$logfile" 2>&1
        printf "complete.\n%4sAdding crispy user to VirtualBox sharing group..."
        sudo usermod -a -G vboxsf robinlfs >> "$logfile" 2>&1
        printf "complete.\n%4sCreating symlink..."
        ln -s /media/sf_HostShare/ $HOME/Host >> "$logfile" 2>&1
        printf "complete.\n%4sUnmounting CD image..."
        sudo umount /media/cdrom >> "$logfile" 2>&1
        printf "complete.\n\n%4sStep one complete."
    fi
    # Since this is an optional step, here isn't an option for [Nn]
}

# STEP TWO: Confirm host development tools.
function StepTwo()
{
    clear
    printf "$stepTwoMsg"

    answer=""
    while [[ $answer != [YyNn] ]]; do
        GetAnswer "Would you like to continue? ${y}Y/N${n} "
    done

    if [[ $answer = [Yy] ]]; then
        clear
        printf "\n%2sConfirm host development tools..."
        export LC_ALL=C

        printf "\n%2sChecking bash..."
        bashVersion=bash --version | head -n1 | cut -d" " -f2-4
        bashLink=$(readlink -f /bin/sh)

        printf "\n%2sChecking binutils..."
        binutilsVersion=ld --version | head -n1 | cut -d" " -f3-
        
        
        
        bison --version | head -n1

        if [ -h /usr/bin/yacc ]; then
            echo "/usr/bin/yacc -> `readlink -f /usr/bin/yacc`";
        elif [ -x /usr/bin/yacc ]; then
            echo yacc is `/usr/bin/yacc --version | head -n1`
        else
            echo "yacc not found" 
        fi

        bzip2 --version 2>&1 < /dev/null | head -n1 | cut -d" " -f1,6-
        echo -n "Coreutils: "; chown --version | head -n1 | cut -d")" -f2
        diff --version | head -n1
        find --version | head -n1
        gawk --version | head -n1

        if [ -h /usr/bin/awk ]; then
            echo "/usr/bin/awk -> `readlink -f /usr/bin/awk`";
        elif [ -x /usr/bin/awk ]; then
            echo awk is `/usr/bin/awk --version | head -n1`
        else 
            echo "awk not found" 
        fi

        gcc --version | head -n1
        g++ --version | head -n1
        ldd --version | head -n1 | cut -d" " -f2-  # glibc version
        grep --version | head -n1
        gzip --version | head -n1
        cat /proc/version
        m4 --version | head -n1
        make --version | head -n1
        patch --version | head -n1
        echo Perl `perl -V:version`
        sed --version | head -n1
        tar --version | head -n1
        makeinfo --version | head -n1
        xz --version | head -n1

        echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c
        if [ -x dummy ]
        then echo "g++ compilation OK";
        else echo "g++ compilation failed"; fi
        rm -f dummy.c dummy


        printf "\nHost development tools report"
        printf "\n-----------------------------"
        printf "RobinBFS needs bash vesion 3.2 - you have version $bashVersion."
        printf "/bin/sh on your system points to $bashLink - "
        if [bashLink == "/bin/bash"]; then
            stepTwoBash="this is correct."
        else
            stepTwoBash="this has not been tested. It should point to \"/bin/bash\"."
        fi
        



        unset bashVersion
        unset bashLink
        unset stepTwoBash



    else
        ExitScript "Exiting script.\n\n"
    fi


}

## MAIN  ---------------------------------------------------------------------------------------------------------------

RobinBFSSetup
WelcomeMessage
StepOne
StepTwo












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
