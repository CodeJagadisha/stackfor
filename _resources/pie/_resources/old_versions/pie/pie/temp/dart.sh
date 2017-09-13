#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie
## Taken from https://www.dartlang.org/install/linux

source "$pieFolder/scripts/piengine.sh"

## Install Dart
function Install()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstall the latest version of Dart"       
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie ""
            ;;
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sUpdating system..."
            sudo apt-get -y update > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sInstalling required packages..."
            sudo apt-get -y install apt-transport-https curl >> "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sAdding sources..."
            sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' >> "$logfile" 2>&1
            sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' >> "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sInstalling Dart..."
            sudo apt-get -y update >> "$logfile" 2>&1
            sudo apt-get -y install dart >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            CompleteActionMsg
            ;;   
        *)
            if (( "$#" > 0 )); then
            ExitPie "Exit message."
            fi   
            ;;
    esac
}

## Display Dart help
function Help() 
{
    DisplayHelp "${0#*./}" "actions" "$validActions"
    ExitPie "Have a nice day!"
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
    Help
fi

##Installed the Dart programming language|00.30.161206|development@aprettycoolprogram.com