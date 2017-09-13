#! /usr/local/bin/python3

# Stacks for dde.py
# Version XX.XX.XXXXXX

# stack.py is called from dde.py, and does stuff with stacks.

# Do we need these?
import os
import sys

# Stop all stacks
def StopAllStacks():
    print("\nStopping all stacks!")
    for stack in range(0,len(stackNames)):                                                          # Loop through list
        print("\nStopping " + stackNames[stack] + "...")
        os.system("sudo /home/development/stacks/" + stackNames[stack] + "/ctlscript.sh stop") # Stop the stack
    print("Success! All stacks have been stopped.\n\n")
    exit()

# Start or stop a stack
def StartStopStack(args):
    print ("\nPreparing to " + args[0] + " " + args[1] + "...")
    os.system("sudo /home/development/stacks/" + args[1] + "/ctlscript.sh " + args[0]) # Start the passed stack
    print("Success!\n")
    exit()

def Soemthing():
    os.system("clear")
    if (len(args) > 1):
        if (args[1] in stackNames):
            StartStopStack(args)
        elif (args[1] == "all"):
            StopAllStacks()
