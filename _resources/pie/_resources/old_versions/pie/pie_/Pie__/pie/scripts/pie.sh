#!/bin/bash
## For more information, please visit http://aprettycoolprogram.com/pie

# This is the main pie script. For the most part, it's the same as any other pie script, aside from the following:
#   1. The pieFolder variable is exported
#   2. External scripts are called, instead of just actions

export pieFolder="$HOME/pie"
source "$pieFolder/scripts/piengine.sh"

## Installs pie.
function Install()
{
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstall pie"
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie ""
            ;;
        "")        
            # If bin/ doesn't exist, create. This is for safety.
            if [ ! -d $HOME/bin ]; then
                mkdir $HOME/bin
                . $HOME/.profile
            fi  
            # If bin/pie symbolic link exists, create. This is for safety.
            if [ ! -L $HOME/bin/pie ]; then 
                ln -s $HOME/pie/scripts/pie.sh $HOME/bin/pie
            fi
            ;;   
        *)
            if (( "$#" > 0 )); then
            ExitPie "Invalid command."
            fi   
            ;;
    esac
    printf "\n\n"
}

## Displays the help screen for pie.
function Help() 
{
    DisplayHelp "${0#*./}"
}

SetVariables
GetFunctionNamesFor "validActions" "${0#*./}"

# If arguments are passed, check to see if the first is an action. If it is, call the action. If it's not an action,
# check to see if it's a script. If it is, call the script and pass any remaining arguments. If it's neither, display
# a help message. If no arguments were passed, display the menu.
if (( "$#" > 0 )); then
    if [[ "${validActions[*]}" =~ "$1" ]]; then
        declare -c action="$1"
	    eval "$action"
    elif [[ "${scriptNames[*]}" =~ "$1.sh" ]]; then
        eval "$pieFolder/scripts/$1.sh ${@:2}"
    else
        ExitPie "Invalid action. Please type \"pie help\" for more information."	
    fi
else
    eval Help
fi

##The main entry point for pie.|00.10.161205|development@aprettycoolprogram.com