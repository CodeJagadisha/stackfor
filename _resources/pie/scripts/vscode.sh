#!/bin/bash
## For use with pie. For additional information, please visit http://aprettycoolprogram.com/pie

source "$pieFolder/scripts/piengine.sh"

## Install VSCode
function Install()
{ 
    # Set logfile.
    SetLogfile "$scriptName" "${FUNCNAME[0],,}" "$@"

    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstalls Visual Studio Code from aprettycoolprogram.com
%2s      source %2sInstalls Visual Studio Code from Microsoft"      
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie ""
            ;;
        "")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sDownloading Visual Studio Code installer..."
            wget -P $HOME/pie/temp http://aprettycoolprogram.com/pie/installers/vscode_1.7.2_amd64.tar.gz > "$logfile" 2>&1
            printf "complete.\n%2sCreating Visual Studio Code directories..."
            mkdir $HOME/dvn >> "$logfile" 2>&1
            mkdir $HOME/dvn/ide >> "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sUncompressing Visual Studio Code..."
            tar -zxvf $HOME/pie/temp/vscode_1.7.2_amd64.tar.gz -C $HOME/dvn/ide/ >> "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sRenaming directory..."
            mv $HOME/dvn/ide/VSCode-linux-x64/ $HOME/dvn/ide/vscode/ >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            CompleteActionMsg
            ;;
        *)
            if (( "$#" > 0 )); then
            ExitPie "Invalid command, exiting."
            fi   
            ;;
    esac
}

## Creates a desktop icon
function Icon()
{
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sCreates a desktop icon for Visual Studio Code
%2s       nogpu %2sCreates a desktop icon for Visual Studio Code that disables the GPU"      
            DisplayHelp "${0#*./}" "icon" "$helpContent"
            ExitPie ""
            ;;
        "")
            appArguments=""
            ;;
        "nogpu")
            appArguments="--disable-gpu"
            ;;     
        *)
            if (( "$#" > 0 )); then
            ExitPie "%2sInvalid command, exiting."
            fi   
            ;;
    esac
    
    StartActionMsg $scriptName ${FUNCNAME[0],,} $@
    printf "%2sCreating desktop icon for Visual Studio Code..."
    DesktopIcon "UTF-8" "1.0" "VS-CODE" "VS-CODE" "/home/dvn/dvn/ide/vscode/code $appArguments" "false" "/opt/yed-3.11.1/icons/yicon32.png" "Application" "Application;Programming;" "Visual Studio Code"
    printf "$desktopIcon" > $HOME/Desktop/vscode.desktop
    chmod +x $HOME/Desktop/vscode.desktop
    printf "${fG}complete!${tR}"
    CompleteActionMsg
}

## Display vscode help
function Help() 
{
    DisplayHelp "${0#*./}" "actions" "$validActions"
}

# Get the valid actions for this script, then get the base script name, since it's used in log files and
# the else statement.
GetFunctionNamesFor "validActions" "${0#*./}"
scriptName="$(basename ${0#*./})"
scriptName="${scriptName%.*}"

# If arguments are passed, check to see if the first is an action. If it is, call the action. If it's not an action,
# display a help message. If no arguments were passed, display the menu.
if (( "$#" > 0 )); then
    if [[ ${validActions[*]} =~ "$1" ]]; then  	
        declare -c action="$1"
	    eval "$action ${@:2}"
    else
        ExitPie "Invalid action. Please type \"pie $scriptName help\" for more information."	
    fi
else
    eval Help
fi

##Does various things with Visual Studio Code|00.10.01.161205|development@aprettycoolprogram.com