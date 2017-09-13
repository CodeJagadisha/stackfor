#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie/bakery
## Taken from https://sourceforge.net/p/open-cobol/wiki/Install%20Guide/

source "$pieFolder/scripts/piengine.sh"

## Installs Cobol
function Install()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstall OpenCobol"       
            DisplayHelp "${0#*./}" "name" "$helpContent"
            ExitPie ""
            ;;
        "")
            Install open
            ;;
        
        "open")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sInstalling required packages..."
            sudo apt-get install libgmp
            printf "${fG}complete!${tR}"
            #printf "${fG}complete!${tR}\n%2sInstalling required packages..."
            #sudo apt-get install libltdl libdb libncurses
            printf "${fG}complete!${tR}n%2sDownloading OpenColbol 2.0rc2..."
            wget-P $HOME/pie/temp https://sourceforge.net/projects/open-cobol/files/gnu-cobol/2.0/gnu-cobol-2.0_rc-2.tar.gz
            printf "${fG}complete!${tR}n%2sUnpacking..."  
            tar -zxvf $HOME/pie/temp/gnu-cobol-2.0_rc-2.tar.gz
            printf "${fG}complete!${tR}n%2sConfiguring..."            
            cd $HOME/pie/temp/gnu-cobol*
            ./configure
            printf "${fG}complete!${tR}n%2sMake..."    
            make
            printf "${fG}complete!${tR}n%2sMake test..."    
            make test
            printf "${fG}complete!${tR}n%2sMakeinstall..."    
            sudo make install
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

##Installs Cobol|00.10.161205|development@aprettycoolprogram.com