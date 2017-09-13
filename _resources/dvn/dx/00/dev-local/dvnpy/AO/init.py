#! /usr/local/bin/python3

# Initializer for dde.py
# Version XX.XX.XXXXXX

# init.py is called from dde.py, and initializes the dde.py environment.

# Do we need these?
import os
import sys
from dde_modules import apcp
from dde_modules import build


def InitialSetup():
    # If the hidden dde folder doesn't exist
    if not (os.path.isfile("/home/development/.dde/dde_initialized")):
        # CODE TO WRITE THE INITIALIZATION DATE TO dde_initialized
        if (os.path.isfile("/home/development/dde_init.sh")): # If the init script exists
            os.system("rm /home/development/dde_init.sh") # Remove it
        if not (os.path.islink("/home/development/bin/dde")): # If a dde --> dde.py doesn't exist
            os.system("ln -s /home/development/bin/dde.py /home/development/bin/dde")
    else:
        print("It seems like the DebDeven environment has already been initialized.")
        exit()


# ADD
# If $PATH doesn't include /home/development/bin, include it
