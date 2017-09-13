#!/bin/bash

#  PROJECT: pie
# FILENAME: vscode.sh
#    BUILD: 170331
#
# Copyright 2017 A Pretty Cool Program
#
# pie is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
#
# For more information about pie, please visit http://aprettycoolprogram.com/pie.

## This slice installs the latest official version of Microsoft's Visual Studio Code IDE for Linux. In addition,
## it can create a desktop icon for Visual Studio Code. For more information about installing Visual Studio Code
## for Linux, please see https://code.visualstudio.com/docs/setup/linux.

# Include all of the logic from pieEngine.
source "$pieFolder/slices/piengine.sh"

# Installs the latest, official version of Microsoft's Visual Studio Code IDE
function Install()
{ 
    # Set logfile name for the this command-action.
    SetLogfileName "$scriptName" "${FUNCNAME[0],,}" "$@"
	
	# Determine the arguments of this action (i.e. "pie <command> <action> <optional-arguments>")
    case $1 in
        "help") # It's "help"! (i.e. "pie <command> <action> help")
            helpContent=
"
%2s      <none> %2sInstalls crispy (DEFAULT)
%2s        help %2sDisplays the help
"      
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie ""
            ;;
        "") # It's nothing! (i.e. "pie <command> <action> ")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
			printf "%2sDownloading Visual Studio Code installer..."
			curl -k https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg  > "$logfile" 2>&1
			sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg >> "$logfile" 2>&1
			sudo sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' >> "$logfile" 2>&1
			sudo apt-get update >> "$logfile" 2>&1
			sudo apt-get install code  >> "$logfile" 2>&1
			#sudo dpkg -i code*.deb
			#sudo apt-get install -f 
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

# Creates a desktop icon for Microsoft's Visual Studio Code IDE
function Icon()
{
    # Determine the arguments of this action (i.e. "pie <command> <action> <optional-arguments>")
	case $1 in
        "help") # It's "help" ("pie pie <command> <action> help")
            helpContent=
"
%2s      <none> %2sCreates a desktop icon for Visual Studio Code
%2s       nogpu %2sCreates a desktop icon for Visual Studio Code that disables the GPU
"      
            DisplayHelp "${0#*./}" "icon" "$helpContent"
            ExitPie ""
            ;;
        "") # It's nothing (i.e. "pie pie <command> <action> ")
            appArguments=""
            ;;
        "nogpu")# It's "nogpu" (i.e. "pie <command> <action> <this_case_statement>")
            appArguments="--disable-gpu"
            ;;     
        *) # It's something other than the above options (i.e. "pie pie <command> <action> blahblahblah")
            if (( "$#" > 0 )); then
            ExitPie "%2sInvalid command, exiting."
            fi   
            ;;
    esac
    
	# Since "$appArguments" can be one of a few options, we'll put this action code outside the case statement.
    StartActionMsg $scriptName ${FUNCNAME[0],,} $@
    printf "%2sCreating desktop icon for Visual Studio Code..."
    DesktopIcon "UTF-8" "1.0" "VS-CODE" "VS-CODE" "/usr/bin/code $appArguments" "false" "/opt/yed-3.11.1/icons/yicon32.png" "Application" "Application;Programming;" "Visual Studio Code"
    printf "$desktopIcon" > $HOME/Desktop/vscode.desktop
    chmod +x $HOME/Desktop/vscode.desktop
    printf "${fG}complete!${tR}"
    CompleteActionMsg
}

# Displays the command help screen.
function Help() 
{
	# <Explaination goes here>
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

##Installs Microsoft's Visual Studio IDE|Build 170331|development@aprettycoolprogram.com