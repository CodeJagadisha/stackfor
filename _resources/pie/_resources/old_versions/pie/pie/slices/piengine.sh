#!/bin/bash

#  PROJECT: pie
# FILENAME: piengine.sh
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

## pieEngine does the heavy lifting for pie.

# Setup important variables for pie.
function SetVariables()
{
    # These need to be environment variables to work properlly.
	
    # Foreground colors
    export fB=$(tput setaf 0); # Black?
	export fR=$(tput setaf 1); # Red?
    export fG=$(tput setaf 2); # Green?
	export fY=$(tput setaf 3); # Yellow?
    export fU=$(tput setaf 4); # Blue?
	export fM=$(tput setaf 5); # Magenta?
    export fC=$(tput setaf 6); # Cyan?
	export fW=$(tput setaf 7); # White?
    # Background colors
    export bB=$(tput setab 0); # Black?
	export bR=$(tput setab 1); # Red?
    export bG=$(tput setab 2); # Green?
	export bY=$(tput setab 3); # Yellow?
    export bU=$(tput setab 4); # Blue?
	export bM=$(tput setab 5); # Magenta?
    export bC=$(tput setab 6); # Cyan?
	export bW=$(tput setab 7); # White?
    # General text formatting
    export tH=$(tput smso); # ?
	export th=$(tput rmso); # ?
    export tU=$(tput smul); # ?
	export tu=$(tput rmul); # ?
    export tB=$(tput bold); # ?
	export tV=$(tput rev); # ?
    export tD=$(tput dim); # ?
	export tL=$(tput blink); # ?
    export tR=$(tput sgr0); # ?

    # List of pie slices, not inlcuding "pie.sh" or "piengine.sh". This grabls every filename in the "pie/slices"
	# directory makes sure it's not "pie.sh" or "pieengine.sh", and then gets the script name (i.e. "<COMMAND>.sh"
	# becomes "<COMMAND>" <--- CONFIRM THIS
    for scriptName in "$pieFolder"/slices/*; do
        if [ ! "$scriptName" == "pie.sh" ] || [ ! "$scriptName" == "piengine.sh" ]; then
            scriptNames=("${scriptNames[@]}" "${scriptName##*/}")  
        fi                             
    done
}

# Exit pie with a message.
function ExitPie()
{
    # If a customized message was not passed, assign a general message. Otherwise, display the custom message.
    if [[ "$#" == 0 ]]; then
        printf "%2sExiting pie...\n\n"
    else
        printf "%2s$1\n\n"
    fi
    exit 1
}

# Display a nicely formatted error message with detailed information.
function ErrorMsg()
{
    printf
"
%2s ${tB}PIE ERROR!${tO}
%2s      FILE:\t$1
%2s  FUNCTION:\t$2
%2s      LINE:\t$3
%2sDESCRIPTION:\t$4\n\n
"
}

# Display a descriptive message when a pie slice executes.
function StartActionMsg()
{
    clear
    printf
"
%2s${tB}--------------${tR} 
%2s${tB} PIE STARTING >${tR}${fC} $1 ${fM} $2 ${fW} ${@:3} ${tR}
%2s${tB}--------------${tR}\n\n
"
}

# Display a descriptive message when a pie slice executes.
function CompleteActionMsg()
{
    printf
"\n
%2s${tB}--------------${tR} 
%2s${tB} PIE FINISHED ${tR}
%2s${tB}--------------${tR}\n\n
"
ExitPie
}

# Set the logfile name.
function SetLogfileName()
{
    # If three arguments were passed (i.e. "pie java install jdk 9 source"), build a complex name by replacing spaces
	# between arguments with the "-" character (i.e. "java-install-jdk-9-source_"). Otherwise the name will just be
	# the script name and action (i.e. "java-install_").
	#
	# The final name will be: "<script>-<action>(-<argument_list>)_<datestamp>.log"
    if (( "$#" >= 3 )); then
        commands="-${@:3}_"
        commands="${commands// /-}"
    else
        commands="_"
    fi
    actionLogfile="$pieFolder/logs/$1-$2$commands$(date "+%Y.%m.%d-%H.%M.%S").log"
}

# Set the manifest name TODO - Make this work.
function SetManifestName()
{
	// CODE-GOES-HERE
}

# Create a desktop icon.
function DesktopIcon()
{
    desktopIcon=
"[Desktop Entry]\n
Encoding=$1
Version=$2
Name[en_US]=$3
GenericName=$4
Exec=$5
Terminal=$6
Icon[en_US]=$7
Type=$8
Categories=$9
Comment[en_US]=${10}"
}

# Get the function names in a file.
function GetFunctionNamesFor()
{
    # We'll need all of the function names in a script to either display help  about them, or to determine a
	# script's validActions.

    # Since this is called often, we need to reset the result each time.
    helpContent=""

    # Read each line, and if it starts with "function", work on it some more.
    while read -r line; do 
        if [[ "$line" == function* ]]; then
            # Remove "function" and its trailing space, then remove the last two characters "()". This is the
			# function name. Force the first character to be lowercase, since CLI entries are lowercase.
            # TODO - Parentheses should be remove, rather than last two chars.
            functionName="${line#*function }"
            functionName="${functionName:0:-2}"
            declare -l functionName="$functionName"
            case "$1" in
                "help")
                    # This needs to be reset each time.
                    spaces=""
                    
                    # If we are building a help page,confirm that the functionName is in the validActions array,
					# find out how many spaces need to be at the start to make things align correctly, then add
					# the spaces and build the entire line.
                    if [[ "${validActions[*]}" =~ "$functionName" ]]; then
                       (( startingSpaces=12-"${#functionName}" ))  
                        counter=0
                        while [ "$counter" -lt "$startingSpaces" ]; do
                            (( counter++ ))
                            spaces=" $spaces"
                        done
                        functionName="$spaces$functionName"
                        helpContent+="%2s$functionName%2s${previousLine//#}\n"
                    fi
                    ;;
                "validActions")
                    # If building a list of valid actions, add the functionName to the list.
                    validActions+=("$functionName")
                    ;;
                *)
                    ;;
            esac
        fi
        # Store the current line in the event that the next line is a validAction. If it is, we'll need this line,
		# since it contains the action description.
        previousLine="$line"
    done < "$2"
}

# Build a common framework for help screens.
function DisplayHelp()
{
    clear
    # Read the last line of the script, and remove "#" characters. Set IFS to be our delimiter, and split the string
	# at "|". Loop through the delimited parts of the string, and store them in an array. Restore the original IFS,
    # and get the basename of the script.
    scriptLastLine=$(tac "$1" | egrep -m 1 .)
    scriptLastLine="${scriptLastLine//#}"
    IFS='|' read -ra details <<< "$scriptLastLine"
    scriptDetails=()
    for detail in "${details[@]}"; do
        scriptDetails+=("$detail")    
    done
    unset IFS
    scriptName=$(basename $1)

    # Build the helpHeader.
    helpHeader=
"
%2s${fW}${tB}-------------  
%2s     PIE
%2s-------------${tR}
%2s${bC}${fB} SCRIPT NAME ${tR}%2s${fC}$scriptName${tR}
%2s${bC}${fB} DESCRIPTION ${tR}%2s${fC}${scriptDetails[0]}${tR}
%2s${bC}${fB}     VERSION ${tR}%2s${fC}${scriptDetails[1]}${tR}
%2s${bC}${fB}      AUTHOR ${tR}%2s${fC}${scriptDetails[2]}${tR}
%2s${fW}${tB}------------- ${tR}
"

# Build the helpBody for pie.sh.    
if [[ "$scriptName" == "pie" ]]; then
        for i in "${scriptNames[@]}"; do
            test+="${i%.*}\n"
        done
        helpBody=
"
%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie [SCRIPT] ${tD}[ACTION] [COMMAND]\"${tR}
%2s${fW}${tB}------------- ${tR}
%2s${bW}${fB}     SCRIPTS ${tR}
\n$test\n
"
else
    # Build the helpBody for a script's actions.  
    if [[ "$2" == "actions" ]]; then
        GetFunctionNamesFor "help" "$1"
        helpBody=
"
%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie ${scriptName%.*} [ACTION] [COMMAND]\"${tR}
%2s${fW}${tB}------------- ${tR}
%2s${bW}${fB}     ACTIONS ${tR}
\n$helpContent
"
    else
        # Build the helpBody for actions.  
        helpBody=
"
%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie ${scriptName%.*} $2 [COMMAND]\"${tR}
%2s${fW}${tB}------------- ${tR}
%2s${bW}${fB}    COMMANDS ${tR}
$3
"
    fi
fi

    # Build the helpFooter.
    helpFooter="\n\n"

    # Print everything.
    printf "$helpHeader $helpBody $helpFooter"
}