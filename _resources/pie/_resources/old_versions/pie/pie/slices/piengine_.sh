#!/bin/bash

## piengine.sh v00.29.161211
## Common logic for pie
## Written by development@aprettycoolprogram
## For more information, please visit http://aprettycoolprogram.com/pie

function SetVariables()
{
    # Need to be environment variables for the text formatting to work.
    # Foreground colors
    export fB=$(tput setaf 0);  export fR=$(tput setaf 1)
    export fG=$(tput setaf 2);  export fY=$(tput setaf 3)
    export fU=$(tput setaf 4);  export fM=$(tput setaf 5)
    export fC=$(tput setaf 6);  export fW=$(tput setaf 7)
    # Background colors
    export bB=$(tput setab 0);  export bR=$(tput setab 1)
    export bG=$(tput setab 2);  export bY=$(tput setab 3)
    export bU=$(tput setab 4);  export bM=$(tput setab 5)
    export bC=$(tput setab 6);  export bW=$(tput setab 7)
    # General text formatting
    export tH=$(tput smso);     export th=$(tput rmso) 
    export tU=$(tput smul);     export tu=$(tput rmul)
    export tB=$(tput bold);     export tV=$(tput rev)  
    export tD=$(tput dim);      export tL=$(tput blink)
    export tR=$(tput sgr0)

    # Get all of the filenames in scripts/ directory, ignoring pie.sh or
    # piengine.sh, and place them into an array.
    for scriptName in "$pieFolder"/scripts/*; do
        #scriptName="$(basename ${0#*./})"
        #scriptName="${scriptName%.*}"
        #echo "FOR: $scriptName - $pieFolder/scripts/pie.sh"
        if [ "$scriptName" == "$pieFolder/scripts/pie.sh" ] || [ "$scriptName" == "$pieFolder/scripts/piengine.sh" ]; then  
            nothing="to see here"
        else
            scriptNames=("${scriptNames[@]}" "${scriptName##*/}")
        fi                             
    done

    # Location of the development branch.
    developmentBranch="Development/Bash/pie/pied/"
}

function CleanupPie()
{
    rm -rf "$pieFolder"/temp/*
}

function ExitPie()
{
    CleanupPie
    printf "%2s$1\n\n"
    exit 1
}

function StartActionMsg()
{
    clear
    printf "
%2s${tB}------------${tR} 
%2s${tB}PIE > START  : ${tR}${fC}$1 ${fM}$2 ${fW}${@:3} ${tR}
%2s${tB}------------${tR}\n\n"
}

function CompleteActionMsg()
{
    printf "\n
%2s${tB}------------${tR} 
%2s${tB}PIE > FINISH : ${tR}$1
%2s${tB}------------${tR}\n\n"
ExitPie
}

function SetLogfileName()
{
    # If three arguments were passed ("pie java install jdk 9 source"), build
    # a complex name by replacing spaces between arguments with the "-"
    # character ("java-install-jdk-9-source_"). Otherwise the name will just be
    # the script name and action ("java-install_"). 
    if (( "$#" >= 3 )); then
        scriptFlags="-${@:3}_"
        scriptFlags="${scriptFlags// /-}"
    else
        scriptFlags="_"
    fi
    
    # Final name will be "<script>-<action>(-<argument_list>)_<datestamp>.log"
    logfile="$pieFolder/logs/$1-$2$scriptFlags$(date "+%Y.%m.%d-%H.%M.%S").log"
}

function SetManifestName()
{
    # If three arguments were passed (i.e. "pie java install jdk 9 source"),
    # build a complex name by replacing spaces between arguments with the
    # "-" character (i.e. "java-install-jdk-9-source_"). Otherwise the name
    # will just be the script name and action (i.e. "java-install_"). The
    # final name will be "<script>-<action>(-<argument_list>)_<datestamp>.log"
    #if (( "$#" >= 3 )); then
    #    commands="-${@:3}_"
    #    commands="${commands// /-}"
    #else
    #    commands="_"
    #fi

    #logfile="$pieFolder/logs/$1-$2$commands$(date "+%Y.%m.%d-%H.%M.%S").log"
    manifest= "test_filename"
}

function DesktopIcon()
{
    desktopIcon="[Desktop Entry]\n
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

function GetFunctionNamesFor()
{
    # We'll need all of the function names in a script to either display help
    # about them, or to determine a script's validActions. Since this is called
    # often, we need to reset clear the helpContent variable each time.
    helpContent=""

    # Read each line, and if it starts with "function", work on it some more.
    while read -r line; do 
        if [[ "$line" == function* ]]; then
            # Remove "function" and its trailing space, then remove the last
            # two characters "()". This is the function name. Force the first 
            # character to be lowercase, since CLI entries are lowercase.
            # TODO - Parentheses should be remove, rather than last two chars.
            functionName="${line#*function }"
            functionName="${functionName:0:-2}"
            declare -l functionName="$functionName"
            case "$1" in
                "help")
                    # This needs to be reset each time to work correctly.
                    spaces=""
                    
                    # If we are building a help page,confirm that the
                    # functionName is in the validActions array, findout how
                    # many spaces need to be at the start to make things align
                    # correctly, then add the spaces and build the entire line.
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
                    # If building a list of valid actions, add the functionName
                    # to the list.
                    validActions+=("$functionName")
                    ;;
                *)
                    ;;
            esac
        fi
        # Store the current line in the event that the next line is a validAction. If it is, we'll
        # need this line, since it contains the action description.
        previousLine="$line"
    done < "$2"
}

function BuildHelpHeader()
{
    helpHeader="
%2s${fW}${tB}-------------  
%2sPIE > HELP
%2s-------------${tR}
%2s${bC}${fB} SCRIPT NAME ${tR}%2s${fC}$scriptName${tR}
%2s${bC}${fB} DESCRIPTION ${tR}%2s${fC}${scriptDetails[0]}${tR}
%2s${bC}${fB}     VERSION ${tR}%2s${fC}${scriptDetails[1]}${tR}
%2s${bC}${fB}      AUTHOR ${tR}%2s${fC}${scriptDetails[2]}${tR}
%2s${fW}${tB}------------- ${tR}"
}

function BuildHelpSyntax()
{
    #echo "----> $@"
    # Needs to have code specific to pie.sh
    if (( "$#" == 0 )); then 
        helpSyntax="\n%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie OPTION ACTION ${tD}[OPTIONS] [FLAGS...]\"${tR} ${bM} OR ${tR} ${fM}\"pie ACTION ${tD}[OPTIONS] [FLAGS...]\"${tR}\n%2s${fW}${tB}------------- ${tR}"
    else
        helpSyntax="\n%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie $scriptName $1 ${tD}[OPTIONS] [FLAGS...]\"${tR}\n%2s${fW}${tB}------------- ${tR}"
        #helpCommands="$1"
    fi
    
    #if [[ "$scriptName" == "pie" ]]; then
    #    helpSyntax="\n%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie COMMAND ACTION ${tD}[OPTIONS] [FLAGS...]\"${tR} ${bM} OR ${tR} ${fM}\"pie ACTION ${tD}[OPTIONS] [FLAGS...]\"${tR}\n%2s${fW}${tB}------------- ${tR}"
    #else
    #    helpSyntax="\n%2s${bM}${fB}      SYNTAX ${tR}%2s${fM}\"pie $scriptName ACTION ${tD}[OPTIONS] [FLAGS...]\"${tR}\n%2s${fW}${tB}------------- ${tR}" 
    #fi   
}

function BuildHelpCommands()
{
    # Currently doesn't work
    if (( "$#" == 0 )); then 
        helpCommands=""
    else
        helpCommands="\n%2s${bW}${fB}    COMMANDS ${tR}\n"
        for i in ${scriptNames[@]}; do
            (( startingSpacesCommands=12-${#i} ))
            commandCounter=0
            while [ "$commandCounter" -lt "$startingSpacesCommands" ]; do
                (( commandCounter++ ))
                withSpaces=" $withSpaces"
            done
            commandListing="$withSpaces$i"
            helpCommands="$helpCommands ${i%.*}\n"
        done
    fi

echo "THIS $helpCommands"
#                       (( startingSpaces=12-"${#functionName}" ))  
#                        counter=0
#                        while [ "$counter" -lt "$startingSpaces" ]; do
#                            (( counter++ ))
#                            spaces=" $spaces"
#                        done
#                        functionName="$spaces$functionName"
#                        helpContent+="%2s$functionName%2s${previousLine//#}\n"


}

function BuildHelpActions()
{
    if (( "$#" == 0 )); then 
        helpActions=""
    else
        # Get the valid actions for the script, then build the help section.
        GetFunctionNamesFor "help" "$pieFolder/scripts/$scriptName.sh"
        helpActions="\n%2s${bW}${fB}     ACTIONS ${tR}\n$helpContent\n\n"
    fi
}

function BuildHelpOptions()
{
    if (( "$#" == 0 )); then 
        helpOptions=""
    else
        helpOptions="\n%2s${bW}${fB}     OPTIONS ${tR}\n$1\n\n"
    fi   
}

function BuildHelpFlags()
{
    if (( "$#" == 0 )); then 
        helpFlags=""
    else
        helpFlags="\n%2s${bW}${fB}       FLAGS ${tR}\n$1\n\n"
    fi    
}

function BuildHelpFooter()
{
    if (( "$#" == 0 )); then 
        helpFooter="\n\n"
    else
        helpFooter="INCOMPLETE CODE."
    fi 
}

function DisplayHelp()
{
    clear

    # Get the script details (i.e. what it does, version, author). This
    # information is stored in the last line of the script, delimited by the
    # "|" character. Read the last line of the script, and remove "#"
    # characters. Set IFS to be our delimiter, and split the string at "|".
    # Loop through the delimited parts of the string, and store them in an
    # array. Then restore the original IFS.
    scriptLastLine=$(tac "$1" | egrep -m 1 .)
    scriptLastLine="${scriptLastLine//#}"
    IFS='|' read -ra details <<< "$scriptLastLine"
    scriptDetails=()
    for detail in "${details[@]}"; do
        scriptDetails+=("$detail")    
    done
    unset IFS

    # Since the header and footer are common, build them then display the help.
    BuildHelpHeader
    BuildHelpFooter
    printf "$helpHeader$helpSyntax$helpCommands$helpActions$helpOptions$helpFlags$helpFooter"
}