#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie/bakery

source "$pieFolder/scripts/piengine.sh"

## Create a new pie.
function New()
{
    # Set logfile.
    SetLogfile $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sCreate a new pie."       
            DisplayHelp "${0#*./}" "name" "$helpContent"
            ExitPie ""
            ;;
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            echo -n "  Name of pie: " # TODO - Force lowercase, use printf
            read pieName
            cp "$pieFolder/templates/template.sh" "$pieFolder/scripts/$pieName.sh"
            printf "\n%2s${fG}$pieName pie created!${tR}"
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
    if [[ ${validActions[*]} =~ "$1" ]]; then  	
        declare -c action="$1"
	    eval "$action ${@:2}"
    else
        ExitPie "Invalid action. Please type \"pie $scriptName help\" for more information."	
    fi
else
    eval Help
fi

##Manegment utility for pie.|00.10.161205|development@aprettycoolprogram.com