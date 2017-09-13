#!/bin/bash
# Initializes and executes the latest version of debimin.sh
# Version 00.05.79.150930



# Check if /home/apcp/logs exists, and create if not
function ExistAPCPDir()
{
	printf "Checking for apcp log directory...
	if [ ! -d $APCPDir/logs ]; then
		printf "  \n... it doesn't exist...creating..."
		mkdir -p $APCPDir/logs
		printf "DONE.\n"
	else
		printf "FOUND.\n"
	fi
}

# Check to see if /home/apcp/debimin/ exists, move log archives then remove if it does
function ExistDebiminDir()
{
	printf "Checking for existing debimin install...
	if [ -d $APCPDir/debimin/logs ]; then  # If the debimin log dir exists, move all the files to the apcp log dir 
    	printf "...existing install found...moving old debimin logs files..."
    	mv -fr $APCPDir/debimin/logs/* /home/apcp/logs
    	printf "DONE.\nRemoving old debimin install..."
    	rm -fr $APCPDir/debimin
	else
		printf "NOT FOUND.\n"
	fi
}

# Create /home/apcp/debimin/*
function CreateDebiminDir()
{
	printf "Creating directories..."
	mkdir -p $APCPDir/debimin/{bin,logs,temp}
	printf "DONE."
}

# Get the latest version of debimin.sh
function GetDebimin()
{
	## DEVELOPMENT CODE
	printf "Downloading required files..."
	wget -r -e robots=off -l1 -p -P $APCPDir/debimin/temp/ --no-directories --no-parent http://www.debdeven.com/debimin/rel/00/  > /home/apcp/debimin/logs/download-reqfiles.log 2>&1
	cd $APCPDir/debimin/temp
	printf "DONE.\nElevating privileges and executing script...see you on the other side! 
	chmod +x debimin.sh
	./debimin.sh

	## LIVE CODE
	#printf "Downloading required files..."
	#wget -P $APCPDir/debimin/temp/ http://www.debdeven.com/debimin/rel/00/debimin.gz > /home/apcp/debimin/logs/dl-debimin.sh.log 2>&1
	#printf "DONE.\nUncompressing files...\n"
	#tar -xzvf $APCPDir/debimin/temp/debimin.gz> /home/apcp/debimin/logs/untar-debimin.log 2>&1
	#cd $APCPDir/debimin/temp
	#printf "DONE.\nElevating privileges and executing script...see you on the other side! 
	#chmod +x debimin.sh
	#./debimin.sh
}

### MAIN

clear
printf "Initializing debimin...\n"
ExistAPCPDir
ExistDebiminDir
CreateDebiminDir
GetDebimin