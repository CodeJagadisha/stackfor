#! /usr/local/bin/python3
# Version 0.90.00-160318
# Deven

import os, sys
from dde_modules import apcp

def DoSomething(arguments):
    # Build
    if (arguments[0] == "build"):
        from dde_modules import build
        validCommands = apcp.FileToList("/home/debdeven/bin/dde_data/build_commands.list")
        if (arguments[1] in validCommands):
            build.Component(arguments)
    # Clean
    if (arguments[0] == "cleanup"):
        from dde_modules import clean
        validCommands = apcp.FileToList("/home/debdeven/bin/dde_data/build_commands.list")
        # DO SOMETHING
    # Help
    if (arguments[0] == "-h") or (arguments[0] == "--help") or (arguments[0] == "help"):
        from dde_modules import menu
        menu.HelpMenu()
    # Init
    if (arguments[0] == "init"):
        from dde_modules import init
        init.InitialSetup()
    # Install
    if (arguments[0] == "install"): # change to add
        from dde_modules import install
        validCommands = apcp.FileToList("/home/debdeven/bin/dde_data/install_commands.list")
        if (len(arguments) == 2):
            if (arguments[1] in validCommands):
                install.Application(arguments[1])
    # Remove
    if (arguments[0] == "remove"):
        from dde_modules import build
        # DO SOMETHING
    # Start or stop
    if (arguments[0] == "start") or (arguments[0] == "stop"):
        from dde_modules import stack
        # DO SOMETHING
    # Update
    if (arguments[0] == "update"):
        from dde_modules import update
        update.UpdateScript()
    # Use
    if (arguments[0] == "use"):
        from dde_modules import use
        if (len(args) == 2):
            validCommands = apcp.FileToList("/home/debdeven/bin/dde_data/use_commands.list")
            if (arguments[1] in validCommands):
                use.Environment(arguments)

# Check to see there is at least one valid command argument
def CheckPrimaryArgument(arguments):

    # Put the valid command arguments into a list
    validCommands = apcp.FileToList("/home/debdeven/bin/dde_data/dde_commands.list")

    # If a vaild command was passed, do something with it
    if (len(arguments) > 0) and (arguments[0] in validCommands):
        DoSomething(arguments)
    # Otherwise let the user know the problem, and exit
    else:
        print("\n\nUnrecognized command. Please see the help file (\"dde help\")\n")
        exit()

# START HERE
CheckPrimaryArgument(sys.argv[1:]) # Get the passed arguments, and strip the first
