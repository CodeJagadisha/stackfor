#! /usr/local/bin/python3

# Installers for dde.py
# Version 0.90.01.150521

# install.py is called from dde.py, and installs various components
# of dde.py.

import os
import sys # need?

def Component(toInstall):

    ## Desktop environments
    # Xfce
    if (toInstall == "xfce"):
        # Add check to make sure Xfce is not already installed.
        os.system("sudo apt-get install xfce4")

    ## Applications
    # Atom
    elif (toInstall == "atom"):
        # Add a check for a 64bit system
        # Add check to make sure both a GUI is installed, and Atom is not already installed.
        print("\nDownloading Atom installer...")
        os.system("wget -O /home/development/temp/atom.deb  http://www.github.com/atom/atom/releases/download/v0.198.0/atom-amd64.deb") # Host local
        print("\nInstalling addtional components...")
        os.system("sudo apt-get install git gconf2 gconf-service libnss3 gvfs-bin xdg-utils")
        print("\nInstalling Atom...")
        os.system("sudo dpkg -i /home/development/temp/atom.deb")
        print("\nInstallation complete.\n")
    # Firefox
    elif (toInstall == "firefox"):
        # Add check to make sure both a GUI is installed, and Atom is not already installed.
        print("\nDownloading Firefox installer...")
        os.system("wget -O /home/development/temp/firefox.tar.bz2 http://www.debdeven.com/installations/stacks/lampstack.tar.bz2")
        # Check to see if these are needed if Atom is not installed
        # If they are, check to see if they are already installed
        #print("\nInstalling addtional components...")
        #os.system("sudo apt-get install git gconf2 gconf-service libnss3 gvfs-bin xdg-utils")
        print("\nInstalling Firefox...")
        os.system("tar -C /home/development/apps -xzf /home/development/temp/firefox.tar.bz2")
        print("\nInstallation complete.\n")

    ## Stacks
    # LAMPstack
    elif (application == "lampstack"):
        if not (os.path.isdir("/home/development/stacks/lampstack")):                                           # If the symlink doesn't exist
            os.system("mkdir /home/development/stacks/lampstack")
            print("\nDownloading lampstack from debdeven.com...")
            os.system("wget -O /home/development/packages/lampstack.tar.bz2 http://www.debdeven.com/installations/stacks/lampstack.tar.bz2")
            print("\nDownload complete.")
            print("\nUnpacking lampstack, this may take a while...")
            os.system("tar -C /home/development/stacks/lampstack -xjf /home/development/temporary/lampstack.tar.bz2")
            print("\nUnpacking complete!\n")
        else:
            print("LAMPstack is already installed on this system")
            exit()

    print("\nCleaning up...")
    os.system("rm -r /home/development/temp *")
