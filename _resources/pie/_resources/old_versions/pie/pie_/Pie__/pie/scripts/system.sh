#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie/bakery

source "$pieFolder/scripts/piengine.sh"

## Update your system.
function Update()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@

    case "$1" in
        "help")
            helpContent="
%2s      <none> %2sUpdate your system (i.e. \"apt-get update\")
%2s          up %2sUpgrade your system (i.e. \"apt-get upgrade\")
%2s         dup %2sUpgrade your specific distro (i.e. \"apt-get dist-upgrade\")"            
            DisplayHelp "${0#*./}" "update" "$helpContent"
            ExitPie ""
            ;;
        "")
            clear
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sUpdating system..."
            sudo apt-get update > "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            CompleteActionMsg
            ;;
        "up")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sUpdating system..."
            sudo apt-get update > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sUpgrading system..."
            sudo apt-get -y upgrade >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            CompleteActionMsg
            ;;
        "dup")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sUpdating system..."
            sudo apt-get update > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sUprading distribution..."
            sudo apt-get -y dist-upgrade >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            CompleteActionMsg
            ;;    
        *)
            if (( "$#" > 0 )); then
            ExitPie "%2sInvalid command, exiting."
            fi   
            ;;
    esac
}

## Display the help for the system functionality.
function Help() 
{
    DisplayHelp "${0#*./}" "actions" "$validActions"
}

# Get the valid actions for this script, then get the base script name, since it's used in log files and
# the else statement
GetFunctionNamesFor "validActions" "${0#*./}"
scriptName="$(basename ${0#*./})"
scriptName="${scriptName%.*}"

# If arguments are passed, check to see if the first is an action. If it is, call the action. If it's not an action,
# display a help message. If no arguments were passed, display the menu.
if (( "$#" > 0 )); then
    if [[ "${validActions[*]}" =~ "$1" ]]; then  	
        declare -c action="$1"
	    eval "$action ${@:2}"
    else
        ExitPie "Invalid action. Please type \"pie $scriptName help\" for more information."	
    fi
else
    eval Help
fi

##Does various system things.|00.10.161205|development@aprettycoolprogram.com