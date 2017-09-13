#!/bin/bash

# DEBIMIN
# v00.05.79.150930
# Copyright (C) 2015 A Pretty Cool Program
# http://aprettycoolprogram.com/debimin
#
# Licensed under Creative Commons (CC BY-NC-SA 3.0)
# http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode

### GLOBAL DEFINITIONS

# Placeholder for common directory locations
apcpDir="/home/apcp"
msgDir="/home/apcp/debimin/msg"
lstDir="/home/apcp/debimin/lst"
version="00"
startSizeHD=df | grep -oP '/sda1.* \K\d+(?=\s+\d+%)' # confirm /sda

### COMMON FUNCTIONS

# Ask question, get answer
function AskQuestion() {
	read -s -n1 -p "$*" answer;
}

# Exit script with custom message
function ExitScript() {
	printf "$*"
    exit
}

# Convert file to string
function FileToString() {
	message=""
	while IFS= read -r fileLine; do
		message+="$fileLine"
	done < "$1"
}

### CHECK FUNCTIONS

# Confirm user is logged in as root, otherwise exit script
function ConfirmRoot() {
    if [ "$USER" != "root" ]; then
        ExitScript "Please login as the root user to run this script.\n\nExiting...";
    fi
}

# Confirm user wants to continue
function ConfirmContinue() {
    #FileToString welcome.msg
    answer=""
    while [[ "$answer" != [YyNn] ]]; do
        clear
        printf "$message"
        AskQuestion "Would you like to continue? Y/N$ "
    done	
    if [[ "$answer" = [Nn] ]]; then
        #Cleanup
        ExitScript "Exiting installer...\n\n"
    fi
}

# Check to see if the prerequisites exist, and create if not
function CheckApcpExists()
{
	printf "Checking for existing APCP install..."
	if [ ! -d $apcpDir/logs ]; then
		printf "  \n... it doesn't exist...creating..."
		mkdir -p $apcpDir/logs
		printf "DONE.\n"
	else
		printf "FOUND.\n"
	fi
}

# Check to see if the prerequisites exist, and create if not
function CheckDebiminExists()
{
	printf "Checking for existing debimin install..."
	if [ -d $apcpDir/debimin]; then
        while [[ "$answer" != [RrUuCc] ]]; do
            printf "An existing debimin install has been found.\n"
            clear
            AskQuestion "Would you like to [R]emove it, [U]pdate it, or [C]ontinue? [r/u/C]? "
        done
    else
        InitializeDebimin
    fi
    
    if [[ $answer == [Rr] ]]; then
        RemoveDebimin
        InitializeDebimin
    elif [[ $answer == [Uu] ]]; then
        UpdateDebimin
    else
        # Continue
    fi
}

### ADD/REMOVE FUNCTIONS

# Remove current version of debimin
RemoveDebimin()
{
    printf "\n\nRemoving existing debimin install..."
    printf "   ...moving old debimin logs..."
    mv -fr $apcpDir/debimin/logs/* $apcpDir/logs
    printf "DONE.\n...removing debimin..."
    rm -fr $apcpDir/debimin
    printf "DONE.\n"
}

UpdateDebimin()
{
    printf "\nUpdating debimin..."
    
    ## DEV CODE
    printf "\n  ...removing old lists and messages..."
	rm $apcpDir/debimin/lst/*
    rm $apcpDir/debimin/msg/*
    printf "DONE.\n   ...downloading current list files..."
	wget -r -e robots=off -l1 -p -P $apcpDir/debimin/lst/ --no-directories --no-parent http://www.debdeven.com/debimin/rel/00/lst/  > /home/apcp/debimin/logs/download-lsts.log 2>&1
    printf "DONE.\n  ...downloading current message files..."
    wget -r -e robots=off -l1 -p -P $apcpDir/debimin/msg/ --no-directories --no-parent http://www.debdeven.com/debimin/rel/00/msg/  > /home/apcp/debimin/logs/download-msgs.log 2>&1
    printf "DONE.\n"
    
    ## LIVE CODE
    #printf "\n  ...removing old lists and messages..."
	#rm $apcpDir/debimin/lst/*
    #rm $apcpDir/debimin/msg/*
	#printf "DONE.\n  ...downloading current list files..."
	#wget -P $apcpDir/debimin/msg/ http://www.debdeven.com/debimin/rel/00/msg.gz > /home/apcp/debimin/logs/download-lsts.log 2>&1
    #printf "DONE.\n  ...downloading current message files..."
	#wget -P $apcpDir/debimin/msg/ http://www.debdeven.com/debimin/rel/00/msg.gz > /home/apcp/debimin/logs/download-msgs.log 2>&1
    #printf "DONE.\n  ...uncompressing files..."
	#tar -xzvf $apcpDir/debimin/temp/debimin.gz> /home/apcp/debimin/logs/untar-msg.log 2>&1
    #tar -xzvf $apcpDir/debimin/temp/debimin.gz> /home/apcp/debimin/logs/untar-lst.log 2>&1
    #printf "DONE.\n"
}

InitializeDebimin()
{
    printf "Initializing debimin environment...\n"
    printf "  ...creating directories..."
    mkdir -p $apcpDir/debimin/{bin,logs,lst,msg,temp}
    printf "DONE.\n  ...copying debimin.sh..."
    cp debimin $apcpDir/debimin/bin
    printf "DONE.\n"
    UpdateDebimin
}




### MAIN ###

ConfirmRoot
ConfirmContinue
CheckApcpExists
CheckDebiminExists








    
    
    

    

	
  
    