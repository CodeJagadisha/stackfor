#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie
## Taken from http://old.haxe.org/download/manual_install#packages

source "$pieFolder/scripts/piengine.sh"

## Install Haxe
function Install()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstall Haxe"       
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie ""
            ;;
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sAdding repository..."
            AddRepository ppa:eyecreate/haxe > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sInstalling Haxe..."
            sudo apt-get -y install haxe >> "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sCreating required directories..."        
            sudo mkdir -p /usr/lib/haxe/lib >> "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sSetting up Haxe..."   
            sudo haxelib setup >> "$logfile" # DON'T OUTPUT TO LOGFILE!
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

## Display Haxe help
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

##Installs the Haxe programming language|00.30.161206|development@aprettycoolprogram.com