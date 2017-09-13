#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie/bakery

# RULES FOR PIE TEMPLATES - You can delete these, of course
#	1. Script filenames must be lowercase (i.e. "scriptname.sh")
#   2. All functions are considered to be valid "actions"
#	3. Function names must be a single word
#   4. Function names must be capitalized
#   5. Function names cannot be more than 11 characters
#	6. Function starting brackets must be on a seperate line (i.e. functions should start "function Function()")
#   7. The last line of the function must have the following format:
#			##Script description|Script version|Script author
#	   i.e.
#			##Install Firefox|1.00.121516|your_email@wherever.com
# 	8. Any comments that start with a single "#" may be removed. Any comments that start with "##" will not be removed.

source "$pieFolder/scripts/piengine.sh"

## Update your system.
function Name()
{
    # Set logfile.
    SetLogfile $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sWhen nothing is entered
%2s     option1 %2sAn option
%2s     option2 %2sAnother option"       
            DisplayHelp "${0#*./}" "name" "$helpContent"
            ExitPie ""
            ;;
        "")
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sDoing somthing..."
            #ACTION_GOES_HERE > "$logfile" 2>&1
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

##Template script for pie.|00.10.161205|development@aprettycoolprogram.com