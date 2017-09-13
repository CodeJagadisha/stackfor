#! /usr/local/bin/python3

# A Pretty Cool Program for dde.py
# Version XX.XX.XXXXXX

# Various utilities written in Python 3.

# Do we need these?
import os
import sys

# Read a file into a list
def FileToList(filename):
    with open(filename) as fileToRead:
        workingList = fileToRead.read().splitlines()

    return(workingList)

# Display some information to the screen
def DisplayInfo(whatToDisplay, indent):
    for line in range(0, len(whatToDisplay)): # Loop through whatever content is passed
        if (indent is "true"):                # If an indent is requested, indent and print
            print("\t" + whatToDisplay[line])
        else:                                 # If and indent is not requested, just print
            print(whatToDisplay[line])
