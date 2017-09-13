#!/bin/bash

#  PROJECT: pie
# FILENAME: crispy.sh
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

# This is the text that will be displayed on the help screen, defining what this action does
function Installs()
{ 
    SetLogfileName "$scriptName" "${FUNCNAME[0],,}" "$@"
	
    case $1 in
        "help")
            helpContent=
"
%2s      <none> %2sWhen no argument is passed (DEFAULT)
%2s        help %2sDisplays the help
%2s     notools %2sDo not install virtualization tools 
"      
            DisplayHelp "${0#*./}" "Install" "$helpContent"
            ExitPie ""
            ;;
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            DATE=$(date +"%Y%m%d%H%M")
            logfile="$HOME/.crispy/build-crispy-pie-$DATE.log"
            buildVersion="170401"

            printf "\n  Creating required directories..." 
	        mkdir -p $HOME/.crispy/{logs,temp}  
            pie system distupgrade
            
            pie package bzip Install
            pie package gcc install
            pie package make install
            pie package curl install
            pie package linux-headers-$(uname -r) install
            pie package xcfe4 install

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

function Help() 
{
    DisplayHelp "${0#*./}" "actions" "$validActions"
}

## MAIN

GetFunctionNamesFor "validActions" "${0#*./}"
scriptName="$(basename ${0#*./})"
scriptName="${scriptName%.*}"
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

##Installs crispy.|170403|development@aprettycoolprogram.com









