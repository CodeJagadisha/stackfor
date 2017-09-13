#! /usr/local/bin/python3

# Version 00.86.151215
# Builds various components of DebDeven environment

import os
import sys # NEED?
from dde_modules import apcp # A Pretty Cool Program for Python3

# Creates folder structure for DebDeven
def FolderStructure():
    folderList = apcp.FileToList("/home/development/bin/dde_data/build_folders.list") # Get folder list
    for folderName in folderList:                                                     # Loop through contents
        if not (os.path.isdir(folderName)):                                           # If the folder doesn't exist
            os.system("mkdir " + folderName)                                          # ...create it

# Creates the DebDeven symbolic links
def SymbolicLinks():
    symlinkList = apcp.FileToList("/home/development/bin/dde_data/build_symlinks.list") # Get symlink list
    for symlink in symlinkList:                                                     # Loop through contents
        symTest = symlink.split()
        if not (os.path.islink(symTest[1])):                                           # If the symlink doesn't exist
            os.system("ln -s " + symlink)                                              # ...create it

def Component(arguments):
    if (arguments[1] == "all"):
        FolderStructure()
        SymbolicLinks()
    elif (arguments[1] == "folders"):
        FolderStructure()
    elif (arguments[1] == "symlinks"):
        SymbolicLinks()
