#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie
## Taken from https://golang.org/doc/install

source "$pieFolder/scripts/piengine.sh"

##Install Go
function Install()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstall Go"       
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie ""
            ;;
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sRemoving previous versions of Go..."
            if [ -d /usr/local/go/ ]; then
                sudo rm -rf /usr/local/go/
            fi
            printf "${fG}complete!${tR}\n%2sDownloading Go 1.7.3..." 
            wget -P $HOME/pie/temp  https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sUnpacking..."   
            sudo tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz
            printf "${fG}complete!${tR}\n%2sAdding Go to PATH..." 
            export PATH=$PATH:/usr/local/go/bin
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

## Display Go help
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

##Installs the Go programming language|00.30.161206|development@aprettycoolprogram.com