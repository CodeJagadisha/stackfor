#!/bin/bash

#  PROJECT: pie
# FILENAME: pie.sh
#    BUILD: 170316
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

# This is the main pie script. For the most part, it's the same as any other pie script, aside from the following:
#   1. The pieFolder variable is exported
#   2. External scripts are called, instead of just actions

export pieFolder="$HOME/pie"
source "$pieFolder/slices/piengine.sh"

# Installs pie.
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
                ln -s $HOME/pie/slices/pie.sh $HOME/bin/pie
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

# Help screen
function Help() 
{
    DisplayHelp "${0#*./}"
}

# MAIN
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
        eval "$pieFolder/slices/$1.sh ${@:2}"
    else
        ExitPie "Invalid action. Please type \"pie help\" for more information."	
    fi
else
    eval Help
fi