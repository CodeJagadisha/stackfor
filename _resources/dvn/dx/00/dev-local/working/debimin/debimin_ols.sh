

# Create file
function Create() {
	FileToString "create-$2"
	#if [ "$1" == "aptconf" ]; then
		#fileName="/etc/apt/apt.conf"
		#fileContent="APT::Install-Recommends \"0\" ; APT::Install-Suggests \"0\" ;"
	#fi
	answer=""
	while [[ "$answer" != [YyNn] ]]; do
		clear
		printf "$message"
		AskQuestion "Would you like to create \"$3$2?\" Y/N$ "
	done
	if [[ "$answer" = [Yy] ]]; then
		case $1 in
            file      ) echo "$4" > "$3$2"
                         ;;
            #directory ) create-dir
            #              ;;
        esac
    fi
}

# Create files
#function CreateFiles() {
#    CreateFile "aptconf" # Create apt.conf
#}

# Do stuff with apt-get
function AptGet() {
    readarray -t packages < "$1-$2"         # List (file) -> array i.e. "install-prerequisites", "purge-safe"

    case $1 in
        install ) for package in ${packages[@]}; do # Loop through
                       InstallPackage $package       # Install current package
                   done
                   ;;
        purge   ) for package in ${packages[@]}; do # Loop through preqs    
                       PurgePackage $package         # Purge current package
                   done
                   ;;
    esac
    
    
#    if [ $1 == "install" ]; then          # Some sort of install
#        for package in ${packages[@]}; do # Loop through
#            InstallPackage $package       # Install current package
#        done
#    elif [ $1 == "purge" ]; then          # Some sort of purge
#        for package in ${packages[@]}; do # Loop through preqs    
#            PurgePackage $package         # Purge current package
#        done
#    fi
}

# Install package
function InstallPackage() {
    FileToString "$debiminDir"/temp/install-"$1".msg # Get message for this install
	logfile=true                                     # Assume we are writing a logfile
    if [ "$1" == "localepurge" ];then                # These installs are interactive, so no logfile
        logfile=false
    fi
    answer=""                                        # Reset answer - FIX?
	while [[ "$answer" != [YyNn] ]]; do              # Keep asking user until they answer Y/N
		clear
		printf "$message"
		AskQuestion "Would you like to install the \"$1\" package? Y/N$ "
	done
	if [[ "$answer" = [Yy] ]]; then
		printf "\n\nInstalling \"$1\" package...\n"
		if $logfile; then
			clear
            apt-get -y install "$1" > "$debiminDir"/logs/install-"$1".log 2>&1
		else
			apt-get -y install "$1"
		fi
	fi
}

# Purge packages
function PurgePackages() {
	FileToString "$debiminDir"/temp/purge-"$1".msg
	readarray -t packages < "$debiminDir"/temp/"$1".purge
	answer=""
	while [[ "$answer" != [YyNn] ]]; do
		clear
		printf "$message"
		for package in ${packages[@]}; do
			printf ""$package"\n"
		done
		AskQuestion "Would you like to purge all packages marked as \""$1"\"? Y/N "
	done
	
	if [[ "$answer" = [Yy] ]]; then
		answer=""
		while [[ "$answer" != [AaIiSs] ]]; do
			printf "\n\n"
			AskQuestion "Would you like to purge [A]ll of the packages, [I]ndividual packages? "
		done
	
		if [[ "$answer" = [Ii] ]]; then
			clear
			printf "Purging individual packages...\n\n"
			for package in ${packages[@]}; do
				answer=""
				while [[ "$answer" != [YyNn] ]]; do
					AskQuestion "  Purge "$package"? Y/N? "
				done
				if [[ "$answer" = [Yy] ]];then
					printf "\n    Ok, purgeing \"$package\"..."
					apt-get -y purge "$1" > "$debiminDir"/logs/purge-"$1".log 2>&1
					printf "DONE!\n"
				else
					printf "    Ok, skipping \"$package\".\n"
				fi	
			done
		else
			printf "Purging \""$1"\" packages..."
			for package in ${packages[*]}; do
				apt-get -y purge "$1" > "$debiminDir"/logs/purge-"$1".log 2>&1
			done
		fi
	fi
}

### MAIN

# Confirm the user is root, and they want to continue
ConfirmRoot
ConfirmContinue

# Prompt user to create apt.conf file
Create file "apt.conf" "/etc/apt/" "APT::Install-Recommends \"0\" ; APT::Install-Suggests \"0\" ;"

# Install prerequisites
AptGet install "prerequisites"

# Purge packages
AptGet purge "safe"
#AptGet purge "risky"
#AptGet purge "dangerous"
#AptGet purge "optional"

# Remove components
#Component remove "dir/to/remove"

# Execute some commands
#Execute cmd "parameters"

# Cleanup
#Cleanup what-to-clean

#stepList=(create-preq install-preq purge remove execute cleanup)
#for step in ${stepList[*]}; do
#    case $step in
#        create   ) Component create "apt.conf" "/etc/apt/" "APT::Install-Recommends \"0\" ; APT::Install-Suggests \"0\" ;"
#                   ;;
#        install  ) AptGet install "prerequisites"
#                   ;;
#        purge    ) AptGet purge "safe"
        #          AptGet purge "risky"
        #          AptGet purge "dangerous"
        #          AptGet purge "experimental"
        #          AptGet purge "optional"
                   ;;
        #remove  ) Component remove "/dir/to/remove"
        #          ;;
        #execute ) Execute "cmd" "parameters
        #          ;;
        #cleanup ) Cleanup "what-to-clean"
        #          ;;
#    esac
#done


	
	#packages=(debfoster localepurge deborphan)
	#for package in ${packages[*]}; do
	#	InstallPackage "$package"
 	#done

	#PurgePackages safe

	
	
	#PurgeThis "safe"
	#PurgeThis "risky"
	#PurgeThis "dangerous"
	#PurgeThis "experimental"
	#RemoveThis "documentation"
	#RemoveThis "manpages"
	#RemoveThis "localefiles"
	#RemoveThis "trash"
	#RemoveThis "kernels"
	#RunThis "deborphan"
	#UpdateAndUpgrade
	#AutocleanAndAutoremove
	#Cleanup + debimin_go.sh
	
	
	# Install SSH at beginning
	#.log and .nolog