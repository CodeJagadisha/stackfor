#! /usr/local/bin/python3

# Menus for dde.py
# Version XX.XX.XXXXXX

# menu.py is called from dde.py, and builds various menus.

# Do we need these?
import os
import sys
from dde_modules import apcp

# Display the help menu to the screen
def HelpMenu():
    os.system("clear")
    helpContent = apcp.FileToList("/home/debdeven/bin/dde_data/help.menu")
    apcp.DisplayInfo(helpContent, "false")
