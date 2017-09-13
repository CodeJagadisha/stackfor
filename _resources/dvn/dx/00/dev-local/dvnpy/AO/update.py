#! /usr/local/bin/python3

# Updaters for dde.py
# Version XX.XX.XXXXXX

# update.py is called from dde.py, and makes sure that the following
# components of dde.py are up-to-date.

# Do we need these?
import os
import sys

# Check to see if dde.py is up-to-date, and download a newer version if not.
def UpdateScript ():
    # Logic to check validity will go here.
    os.system("clear")
    os.system("wget -O /home/development/bin/dde.py http://www.debdeven.com/dde.py") # change ruby
