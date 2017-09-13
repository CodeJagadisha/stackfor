#! /usr/local/bin/python3

# Use for dde.py
# Version XX.XX.XXXXXX

# use.py is called from dde.py, and use various components
# of dde.py.

# Do we need these?
import os
import sys

def Environment(environment):
    if (environment == "ruby18"):
        os.system("rvm use 1.8.7") # change ruby
        print("GO!")
