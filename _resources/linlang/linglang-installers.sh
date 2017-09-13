#!/bin/bash

# Contains installer logic for linlang.sh.
# v00.00.02.161122
# http://aprettycoolprogram/linglang

# Whenever possible, language installation steps are taken from the recommended processes, with the following
# exceptions:
#
#   All wget/curl commands are modified to point to $HOME/linlang_temp/

function InstallCobol()
{
    InstallPackages libgmp                   # Required
    InstallPackages libltdl libdb libncurses # Optional
    wget https://sourceforge.net/projects/open-cobol/files/gnu-cobol/2.0/gnu-cobol-2.0_rc-2.tar.gz
    tar zxvf gnu-cobol-2.0_rc-2.tar.gz
    cd gnu-cobol*
    ./configure
    make
    make test
    sudo make install
}

function InstallDart()
{ 
    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'    
    sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
    sudo apt-get update
    sudo apt-get install dart
}

function InstallGo()
{
    # Previous versions of Go must be removed.
    if [ -d /usr/local/go/ ]; then
        sudo rm -rf /usr/local/go/
    fi
    wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
}

function InstallHaxe()
{
    AddRepository ppa:eyecreate/haxe
    InstallPackages haxe 
    sudo mkdir -p /usr/lib/haxe/lib
    sudo haxelib setup
}

function InstallJava()
{
    clear
    printf "\n\n"
    PS3="Which version of Java would you like to install? "
    select option in OpenJava OracleJava
    do
        case $option in
            OpenJava )
                InstallPackages default-jdk
                ExitScript
                ;;
            OracleJava )
                InstallPackages oracle-java8-installer oracle-java8-set-default
                ExitScript
                ;;
            * )
                ExitScript ;;
        esac
    done
}

function InstallLatex()
{
    # Previous versions of LaTeX must be removed.
    if [ -d /usr/local/texlive/2016 ];then     
        rm -rf /usr/local/texlive/2016
        rm -rf ~/.texlive2016
    fi

    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar zxvf install-tl-unx.tar.gz
    cd install-tl*
    sudo ./install-tl
    PATH=/usr/local/texlive/2016/bin/x86_64-linux:$PATH 
}

function InstallLua()
{
    curl -R -O http://www.lua.org/ftp/lua-5.3.3.tar.gz
    tar zxf lua-5.3.3.tar.gz
    cd lua*
    make linux test
    sudo make linux install
}

function InstallNodeJS()
{
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

function InstallProlog()
{
    # This is here, and broken up, because as one line it was too long.
    InstallPackages build-essential autoconf curl chrpath pkg-config ncurses-dev libreadline-dev libunwind-dev libgmp-dev libssl-dev unixodbc-dev zlib1g-dev
    InstallPackages libarchive-dev libossp-uuid-dev libxext-dev libice-dev libjpeg-dev libxinerama-dev libxft-dev libxpm-dev libxt-dev libdb-dev openjdk-8-jdk junit
}

function InstallPython()
{  
    clear
    printf "\n\n"
    PS3="Which version of Python would you like to install? "
    select option in Python2 Python3
    do
        case $option in
            Python2 )
                printf "\n\n NOT IMPLEMENTED YET."
                ExitScript
                ;;
            Python3 )
                wget -O https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz  
                tar xzfv Python-3.5.2.tgz  
                cd Python-3*
                ./configure
                make
                make test
                sudo make install
                ExitScript
                ;;
            * )
                ExitScript;;
        esac
    done
}

function InstallQt()
{
    wget http://download.qt.io/official_releases/qt/5.7/5.7.0/qt-opensource-linux-x64-5.7.0.run
    chmod +x qt-opensource-linux-x64-5.7.0.run
    ./qt-opensource-linux-x64-5.7.0.run
    InstallCpp
    InstallPackages libfontconfig1
    InstallPackages mesa-common-dev libglu1-mesa-dev -y
}

function InstallRust()
{
    curl -sSf https://static.rust-lang.org/rustup.sh | sh		
}

function InstallSwift()
{
	InstallPackages clang libicu-dev
    #wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - # DISABLED AFTER FIRST USE
    wget https://swift.org/builds/swift-3.0.1-release/ubuntu1604/swift-3.0.1-RELEASE/swift-3.0.1-RELEASE-ubuntu16.04.tar.gz
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
    gpg --verify swift-3.0.1-RELEASE-ubuntu16.04.tar.gz.sig
    mkdir $HOME/Compilers/Swift
    tar xzfv swift-3.0.1-RELEASE-ubuntu16.04.tar.gz -C $HOME/Compilers/Swift
    export PATH=/$HOME/Compilers/usr/bin:"${PATH}"
    exit 1

}

function InstallTclTk()
{	
    wget -O http://downloads.activestate.com/ActiveTcl/releases/8.5.18.0/ActiveTcl8.5.18.0.298892-linux-x86_64-threaded.tar.gz 
    tar xzfv ActiveTcl8.5.18.0.298892-linux-x86_64-threaded.tar.gz 
    cd ActiveTcl8.5*    
    ./install.sh		
}
