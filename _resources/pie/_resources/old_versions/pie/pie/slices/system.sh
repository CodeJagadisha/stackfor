#!/bin/bash

#  PROJECT: pie
# FILENAME: system.sh
#    BUILD: 170403
#
# >>> THIS SCRIPT IS INTENDED TO BE USED WITH pie. <<<
#
# For more information about pie, please visit http://aprettycoolprogram.com/pie.
#
# Copyright 2017 <YOUR-NAME-HERE>
#
# This script is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.

# Include all of the logic from pieEngine.
source "$pieFolder/scripts/piengine.sh"

# Updates your environment
function Upgrade()
{ 
    SetLogfileName "$scriptName" "${FUNCNAME[0],,}" "$@"
	helpContent=
"
\n%2s      <none> %2sUpdate your system (i.e. \"apt-get update && apt-get update && apt-get dist-upgrade\")
"  	
	
    case $1 in
			  "") 	StartActionMsg $scriptName ${FUNCNAME[0],,} $@	
					printf "%2sUpdating system..."
					sudo apt-get -y update > "actionLogfile" 2>&1
					printf "${fG}Done!\n  ${tR}\n%2sUpdating system..."
					sudo apt-get -y update > "$actionLogfile" 2>&1
					printf "${fG}Done!!${tR}\n%2sUpgrading distribution..."
					sudo apt-get -y dist-upgrade >> "$actionLogfile" 2>&1
					printf "${fG}Done!${tR}"
					CompleteActionMsg
					;;
			help)	DisplayHelp "${0#*./}" "Update" "$helpContent"
					ExitPie ""
					;;
			   *) 	if (( "$#" > 0 )); then
						ExitPie "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
					fi   
					;;
	esac
}

# This is the text that will be displayed on the help screen, defining what this action does
function Create()
{ 
    SetLogfileName "$scriptName" "${FUNCNAME[0],,}" "$@"
	helpContent=
"
%2s      <none> %2sWhen no argument is passed (DEFAULT)
%2s        help %2sDisplays the help
%2s     upgrade %2sUpgrades the system (apt-get update && apt-get upgrade)
%2s distupgrade %2sUpgrades the system (apt-get update && apt-get upgrade && apt-get dist-upgrade)
"  

    case $1 in
	 "directory") 	StartActionMsg $scriptName ${FUNCNAME[0],,} $@
					if (( "$2" != null ))
						mkdir "$HOME/$2"   <++++++++++++++++STOPPED
					fi
					
					printf "%2sCreating directory.."
					sudo apt-get -y update > "actionLogfile" 2>&1
					printf "${fG}complete!${tR}"
					CompleteActionMsg
					printf "%2sUpdating system..."
					sudo apt-get -y update > "$actionLogfile" 2>&1
					printf "${fG}complete!${tR}\n%2sUprading distribution..."
					sudo apt-get -y dist-upgrade >> "$actionLogfile" 2>&1
					printf "${fG}complete!${tR}"
					CompleteActionMsg
					;;
			help)	DisplayHelp "${0#*./}" "Update" "$helpContent"
					ExitPie ""
					;;
			   *) 	if (( "$#" > 0 )); then
						ExitPie "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
					fi   
					;;
	esac
}

## Display XXX help
function Help() 
{
    DisplayHelp "${0#*./}" "actions" "$validActions"
}

## MAIN

# Since each function of this script is technically an action this script can perform, we'll get all of the function
# names and put them in a list that we'll use later.
GetFunctionNamesFor "validActions" "${0#*./}"

# Get the base script name, since it's used in log files and the else statements in each function. The first statement
# determines the scripts basename (i.e."/directory/subdirectory/scriptname.sh" becomes "scriptname.sh"), and the
# second statement strips the ".sh" (i.e. "scriptname.sh" becomes ""scriptname").
scriptName="$(basename ${0#*./})"
scriptName="${scriptName%.*}"

# If arguments are passed, check to see if the first is an action by checking to see if it is included
# in "validActions". If it is, call the action. For example the command "pie vscode install", has an action
# of "install", so we would call the "Install" function in the "vscode.sh" script". If an argument is passed,
# and it's not a validAction, quit pie and inform the user they should view the help. If no arguments are
# passed (i.e. "pie vscode"), display the help content for the script. This is the same as the
# "pie vscode" command.
if (( "$#" > 0 )); then
    if [[ ${validActions[*]} =~ "$1" ]]; then  	
        declare -c action="$1"
	    eval "$action ${@:2}"
    else
        ExitPie "Invalid action. Please type \"pie $scriptName help\" for more information."	
    fi
else
    Help
fi

##Does things with the system.|Build 170401|development@aprettycoolprogram.com