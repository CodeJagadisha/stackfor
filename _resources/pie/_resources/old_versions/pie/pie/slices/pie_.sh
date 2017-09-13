#!/bin/bash
## For more information, please visit http://aprettycoolprogram.com/pie

# This is the main pie script. For the most part, it's the same as any other pie script, aside from the following:
#   1. The pieFolder variable is exported
#   2. External scripts are called, instead of just actions

export pieFolder="$HOME/pie"
source "$pieFolder/scripts/piengine.sh"

## Archives the a pie directory
function Archive()
{
    # Set logfile name and display a start message.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    StartActionMsg $scriptName ${FUNCNAME[0],,} $@

    case $1 in
        "help")
            helpContent="
%2s      <none> %2sCreate a compressed tar of the local stable install
%2s         dev %2sCreate a compressed tar of the local development install
%4s         local %2sCreate a compressed tar of the local development install
%2s         tar %2sCreate an uncompressed tar the local development install"      
            DisplayHelp "${0#*./}" "archive" "$helpContent"
            ExitPie
            ;;
        "")
            printf "%2sCreating compressed tar of local install..."
            cd "$pieFolder"
            tar zcvf "$pieFolder"/temp/pie.tar.gz * > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sMoving to pie/snapshots..."
            mv "$pieFolder"/temp/pie.tar.gz "$pieFolder"/snapshots/ >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            ;;
        "dev")
            printf "%2sCreating compressed tar of development install..."
            cd "$developmentBranch"
            tar zcvf "$pieFolder"/temp/pied.tar.gz * > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sMoving to pie/snapshots..."
            mv "$pieFolder"/temp/pied.tar.gz "$pieFolder"/snapshots/ >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            ;;

        "tar")
            printf "%2sCreating uncompressed tar of local install..."
            cd "$pieFolder"
            tar cvf "$pieFolder"/temp/pie.tar.gz * > "$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sMoving to pie/snapshots..."
            mv "$pieFolder"/temp/pie.tar.gz "$pieFolder"/snapshots/ >> "$logfile" 2>&1
            printf "${fG}complete!${tR}"
            ;;
        *)
            if (( "$#" > 0 )); then
                declare -l lowercaseName="${FUNCNAME[0]}"
                StartActionMsg $scriptName ${FUNCNAME[0],,} $@
                printf "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
                CompleteActionMsg
                ExitPie
            fi   
            ;;
    esac

    CompleteActionMsg "Exiting..."
}

## Cleanup a pie installation
function Clean()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sDo all of the cleaning"       
            DisplayHelp "${0#*./}" "clean" "$helpContent"
            ExitPie
            ;;
        "")
            Clean temp
            ;; 
        "temp")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sRemoving temporary files..."
            rm -rf $HOME/pie/temp/
            printf "${fG}complete!${tR}"
            CompleteActionMsg
            ;;          
        *)
            if (( "$#" > 0 )); then
                declare -l lowercaseName="${FUNCNAME[0]}"
                StartActionMsg $scriptName ${FUNCNAME[0],,} $@
                printf "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
                CompleteActionMsg
                ExitPie
            fi   
            ;;
    esac
}

## Get a new version of pie
function Getpie()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s${bW}${fB}     ACTIONS ${tR}
%2s<none>       %2sInstall the stable branch from APrettyCoolProgram
%2sdev          %2sInstall the development branch from APrettyCoolProgram
%2s  local      %2sInstall the development branch from a local machine"     
            DisplayHelp "${0#*./}" "getpie" "$helpContent"
            ExitPie
            ;;
        "")
            printf "will pull stable branch from web"
            ;; 
        "dev")
            StartActionMsg $scriptName ${FUNCNAME[0],,} $@
            printf "%2sSetting up necessary installers and logfiles..."
            mkdir $HOME/pietemp
            cp $pieFolder/scripts/pie* $HOME/pietemp
            logfile="pietemp/pie-getpie-dev-local_$(date "+%Y.%m.%d-%H.%M.%S").log"
            printf "${fG}complete!${tR}\n%2sRemoving previous installations of pie..."
            if [ -d $HOME/pie ]; then
                rm -rf $HOME/pie/
                rm $HOME/bin/pie*
            fi
            printf "${fG}complete!${tR}\n%2sCreating required directories..."
            mkdir -p $HOME/pie/{logs,temp} > "$HOME/$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sCopying the local development version of pie..."
            cp -rf Development/Bash/pie/pied/* pie/ >> "$HOME/$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sCleaning up..."
            rm -rf $HOME/pie/temp/* >> "$HOME/$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sInstalling pie..."
            $HOME/pie/scripts/pie.sh install >> "$HOME/$logfile" 2>&1
            printf "${fG}complete!${tR}\n%2sCleaning up..."
            mv  "$HOME/$logfile" 2>&1 $HOME/pie/logs
            rm -rf $HOME/pietemp
            printf "${fG}complete!${tR}"
            CompleteActionMsg "Exiting..."
            ;;          
        *)
            if (( "$#" > 0 )); then
                declare -l lowercaseName="${FUNCNAME[0]}"
                StartActionMsg $scriptName ${FUNCNAME[0],,} $@
                printf "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
                CompleteActionMsg
                ExitPie
            fi   
            ;;
    esac
}

## List available pie scripts
function List()
{
    # Set logfile.
    SetLogfileName $scriptName ${FUNCNAME[0],,} $@
    
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sList all pie scripts"       
            DisplayHelp "${0#*./}" "scripts" "$helpContent"
            ExitPie
            ;;
        "")
            List help
            ;;   
        *)
            if (( "$#" > 0 )); then
                declare -l lowercaseName="${FUNCNAME[0]}"
                StartActionMsg $scriptName ${FUNCNAME[0],,} $@
                printf "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
                CompleteActionMsg
                ExitPie
            fi   
            ;;
    esac
}

## Installs pie
function Install()
{
    case $1 in
        "help")
            helpContent="
%2s      <none> %2sInstall pie"
            DisplayHelp "${0#*./}" "install" "$helpContent"
            ExitPie
            ;;
        "")        
            # If bin/ doesn't exist, create. This is for safety.
            if [ ! -d $HOME/bin ]; then
                mkdir $HOME/bin
                . $HOME/.profile
            fi  
            # If bin/pie symbolic link exists, create. This is for safety.
            if [ ! -L $HOME/bin/pie ]; then 
                ln -s $HOME/pie/scripts/pie.sh $HOME/bin/pie
            fi
            ;;   
        *)
            if (( "$#" > 0 )); then
                declare -l lowercaseName="${FUNCNAME[0]}"
                StartActionMsg $scriptName ${FUNCNAME[0],,} $@
                printf "%2sInvalid command. Please type \"${fM}pie $lowercaseName help${tR}\" for more information." 
                CompleteActionMsg
                ExitPie
            fi   
            ;;
    esac
    printf "\n\n"
}

## Display help for pie
function Help() 
{
    echo "$scriptNames"
    BuildHelpSyntax
    BuildHelpCommands "${scriptNames[*]}"
    BuildHelpActions "$scriptName"
    BuildHelpOptions
    BuildHelpFlags
    DisplayHelp "${0#*./}" 
    ExitPie
}

SetVariables
GetFunctionNamesFor "validActions" "${0#*./}"
scriptName="$(basename ${0#*./})"
scriptName="${scriptName%.*}"

# If arguments are passed, check to see if the first is an action. If it is, call the action. If it's not an action,
# check to see if it's a script. If it is, call the script and pass any remaining arguments. If it's neither, display
# a help message. If no arguments were passed, display the menu.
if (( "$#" > 0 )); then
    if [[ "${validActions[*]}" =~ "$1" ]]; then
        declare -c action="$1"
	    eval "$action ${@:2}"
    elif [[ "${scriptNames[*]}" =~ "$1.sh" ]]; then
        eval "$pieFolder/scripts/$1.sh ${@:2}"
    else
        ExitPie "Invalid action. Please type \"$scriptName help\" for more information."	
    fi
else
    Help
fi

##The main entry point for pie|00.29.161211|development@aprettycoolprogram.com