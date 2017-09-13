#!/bin/bash
# dvnbk.sh
# v00.90.00-160320
# Backup current development version of dvn.py

# Copy
cp $HOME/Scripts/dvn/* $HOME/Development/Projects-current/Deven/dx/00/dvn/dev/
# Backup
DATE=$(date +"%Y%m%d%H%M")
tar -czvf $HOME/Development/Projects-current/Deven/dx/00/dvn/dev/old_versions/build-$DATE.tar.gz -C $HOME/Deven/Scripts/dvn/*