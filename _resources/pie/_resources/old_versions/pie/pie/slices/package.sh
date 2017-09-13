#!/bin/bash

#  PROJECT: pie
# FILENAME: <COMMAND>.sh
#    BUILD: <VERSION>
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

# [BEGIN - Documentation section. This can be deleted.]
#
# This is a slice template.
#
# A slice template defines what ACTIONS (i.e. "update") and ARGUMENTS (i.e. "silent") are available to pie
# COMMANDS (i.e. "system"), and the logic behind each of them.
#
# Here is an example of a pie command that updates your system, but hides all of the details:
#
#	"pie system update silent"
#    
# Slices are simply shell scripts that have a specific structure. This template is that structure.
#
# There are a few rules you need to follow when you create a slice:      
#
#	1. The script name should be the name of the command, and must be lowercase (i.e. "system.sh")
#
#	2. Each function you write is an action that the command can execute (i.e. "silent".
#
#	3. Function names must be a single word (i.e. "Update")
#
#	4. Function names must be capitalized (i.e. "Update"). The user can type the action using any combination
#	   of cases, they will be converted uppercase first letter, lowercase remaining characters. For instance,
#	   it doesn't matter if action is "update" or "Update" or "UpDaTe", all will be converted to "Update"
#
#	5. Function names cannot be more than 11 characters long. This is so actions are not too long. Multiple
#	   arguments can be used, if necessary
#
#	6. Function brackets must be on a seperate line, like so:
#
#			function Update()
#			{
#				// Logic goes here
#			}
#
#	7. The last line of the function must have the following format:
#			
#			##Script description|Script version|Script author
#
#		For example:
#
#			##Does a bunch of system things|1.0.0|yourname@youraddress.com
#
#	8. Any comments that start with a single "#" may be removed. Any comments that start with "##" should not,
#	   be removed, since they are part of the logic of pieEngine.
#
# [END- Documentation section.]

# Include all of the logic from pieEngine.
source "$pieFolder/scripts/piengine.sh"

# This is the text that will be displayed on the help screen, defining what this action does
function <ACTION1>() # <----- REPLACE WITH ACTION #1 NAME
{ 
    # Set logfile name for the this command-action.
    SetLogfileName "$scriptName" "${FUNCNAME[0],,}" "$@"
	




	# This one is wierd. We're looking for $1, which is the action for the package. i.e. "install" or "remove".
    case $2 in
        "install")
            helpContent=
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@

            sudo apt-get install "$1"

            ;;
        "")
         *)

#    case $1 in
#        "help") # It's "help"! (i.e. "pie <command> <action> help")
#            helpContent=
#"
#%2s      <none> %2sWhen no argument is passed (DEFAULT)
#%2s        help %2sDisplays the help
#%2s     option1 %2sOption #1 description
#%2s     option2 %2sOption #2 description
#"      
#            DisplayHelp "${0#*./}" "<ACTION>" "$helpContent" # <----- REPLACE <ACTION> WITH THE FUCNTION NAME
#            ExitPie ""
#            ;;
#        "") # It's nothing! (i.e. "pie <command> <action> ")
#            StartActionMsg $scriptName ${FUNCNAME[0],,} $@


















            printf "${fG}complete!${tR}"
            CompleteActionMsg 
            ;;
        *) # It's something other than the above options! (i.e. "pie <command> <action> blahblahblah")
            if (( "$#" > 0 )); then
            ExitPie "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
            fi   
            ;;
    esac
}

# This is the text that will be displayed on the help screen, defining what this action does
function <ACTION2>() # <----- REPLACE WITH ACTION #2 NAME
{ 
    # Set logfile name for the this command-action.
    SetLogfileName "$scriptName" "${FUNCNAME[0],,}" "$@"
	
	# Determine the arguments of this action (i.e. "pie <command> <action> <optional-arguments>")
    case $1 in
        "help") # It's "help"! (i.e. "pie <command> <action> help")
            helpContent=
"
%2s      <none> %2sWhen no argument is passed (DEFAULT)
%2s        help %2sDisplays the help
%2s     option1 %2sOption #1 description
%2s     option2 %2sOption #2 description
"      
            DisplayHelp "${0#*./}" "<ACTION>" "$helpContent" # <----- REPLACE <ACTION> WITH THE FUCNTION NAME
            ExitPie ""
            ;;
        "") # It's nothing! (i.e. "pie <command> <action> ")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sDoing something..."
            #CODE-GOES-HERE > "actionLogfile" 2>&1 # <----- PUT LOGIC FOR THE ACTION HERE
            printf "${fG}complete!${tR}"
            CompleteActionMsg 
            ;;
        *) # It's something other than the above options! (i.e. "pie <command> <action> blahblahblah")
            if (( "$#" > 0 )); then
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

##Template script for pie.|00.30.161206|development@aprettycoolprogram.com