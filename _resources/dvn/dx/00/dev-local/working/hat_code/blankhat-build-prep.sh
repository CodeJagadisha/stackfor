#!/bin/bash
# blankhat-build-prep.sh
# v00.90.00-160318
# Initialized Deven Hat "Blank"

# Make sure the temporary directory is empty
sudo rm -rf $HOME/Deven/Temp/*

# Download the scripts that are required to build this hat
wget -O $HOME/Deven/Temp/blankhat-build.manifest http://aprettycoolprogram.com/deven/dx/00/scripts/build/hat/blank/blankhat-build.manifest
cd $HOME/Deven/Scripts
#TODO Make sure these overwrite older files
wget --input-file=$HOME/Deven/Temp/blankhat-build.manifest --continue 

# Execute the hat start script
chmod +x blankhat-build-start.sh
./blankhat-build-start.sh

# Cleanup
sudo rm -rf $HOME/Deven/Temp/*