#!/bin/bash

# Contains main logic for linlang.sh, which installs various programming languages.
# v00.00.02.161122
# http://aprettycoolprogram/linglang

# WARNING
# -------
# This is the development version of linlang.sh, and requires:
#
#   * A Debian-based system (Debian, Ubuntu, etc)
#   * 64-bit x86 architecture
#
# This script only contains the main logic, so, you'll also need "linglang-installers.sh", which
# contains the most of the installer logic, with the exception of a few languages whose installation
# process is more involved. Those installers can be found in "linglang-installer-LANGUAGE.sh" files.
#
# This script was tested on a 64-bit Xubuntu VirtualBox VM.
#
# The list of languages was taken from https://en.wikipedia.org/wiki/List_of_programming_languages, last
# modified on 11-17-2016.

# The installer script is required!
. linglang-installers.sh

function LinlangInitialization()
{
    if [ ! -d $HOME/Compilers ]; then
        mkdir $HOME/Compilers
    fi
}

# In order to avoid issues that may occur if this script is terminated unexpectedly, each function must be called
# explicitly. Calling this function without a parameter will result in an error.
function TemporaryDirectory()
{
    if [ "$1" == "create" ] && [ ! -d $HOME/linlang_temp/ ]; then
        mkdir $HOME/linlang_temp/
        cd $HOME/linlang_temp/
    elif [ "$1" == "remove" ]; then
        if [ -d $HOME/linlang_temp/ ]; then
            cd
            rm -rf $HOME/linlang_temp/
        fi
    else
        ExitScript "ERROR - [FUNC] TemporaryDirectory: Incorrect or missing parameter."
    fi
}

# Lists all of the languages that can be installed.
function ListAllLanguages()
{
    clear
    printf "\n\n  You can install the following languages:\n\n"
    for item in ${languageArray[*]}
    do
        printf "  %s\n" $item
    done
}

# Performs system updates and upgrade/dist-upgrades.
function SystemUpdate()
{
    #printf "\n\n DISABLED FOR DEVELOPMENT"
    sudo apt-get update
    
    if [ "$1" == upgrade ]; then
        sudo apt-get upgrade
    elif [ "$1" == dist-upgrade ]; then
        sudo apt-get dist-upgrade
    else
        ExitScript "ERROR - [FUNC] UpdateUpgrade: Incorrect or missing parameter."
    fi
}

# Exits the script with an optional message to the user. Also removes the temporary directory.
function ExitScript()
{
    if [ "$#" -gt 0 ]; then
        printf "\n\n  "$1"\n"
    fi
    TemporaryDirectory remove
    exit 1
}

# Help!
function LinglangHelp()
{
    clear
    echo "This is the help screen."
}

# Installs packages.
function InstallPackages()
{
    sudo apt-get install "$@"   
}

# Adds PPA Repositories
function AddRepository()
{
    sudo add-apt-repository "$@"
    SystemUpdate  
}

## MAIN

# Make sure requirements exist.
LinlangInitialization

# Force the removal of the temporary directory, if it exists, then create it.
TemporaryDirectory remove
TemporaryDirectory create

# Create the list of languages. This is a manual process.
languageArray=( "ada"
                "c"
                "cobol"
                "c++"
                "dart"
                "fortran"
                "go"
                "haskell"
                "haxe"
                "latex"
                "lisp"
                "lua"
                "java"
                "nodejs"
                "pascal"
                "prolog"
                "python"
                "qt"
                "r"
                "ruby"
                "rust"
                "swift"
                "tcltk"
                "yorick" )

# Depending on the passed argument, do something.
if [[ $# -eq 1 ]]; then

    if [ "$1" in ${languageArray[*]} ]; then
        SystemUpdate
    fi
exit 1
    case "$1" in
        "ada"       ) InstallPackages gnat;;
        "c"         ) InstallPackages build-essentials;;
        "cobol"     ) InstallCobol;;
        "cpp"       ) InstallPackages build-essentials;;
        "dart"      ) InstallDart;;
        "fortran"   ) InstallPackages gfortran;;
        "go"        ) InstallGo;;
        "haskell"   ) InstallPackages haskell-platform;;
        "haxe"      ) InstallHaxe;;
        "latex"     ) InstallLatex;;
        "lisp"      ) InstallPackages clisp;;
        "lua"       ) InstallLua;;
        "java"      ) InstallJava;;
        "nodejs"    ) InstallNodeJS;;
        "pascal"    ) InstallPackages fp-compiler;;
        "prolog"    ) InstallProlog;;
        "python"    ) InstallPython;;
        "qt"        ) InstallQt;;
        "r"         ) InstallPackages r-base r-recommended ;;
        "ruby"      ) InstallPackages ruby-full;;
        "rust"      ) InstallRust;;
        "swift"     ) InstallSwift;;
        "tcltk"     ) InstallTclTk;;
        "yorick"    ) InstallPackages yorick;;
        "all"       ) InstallAllLanguages;;
        "list"      ) ListAllLanguages;;
        "help"      ) LinglangHelp;;
        *           ) ExitScript;;
    esac

    if [ "$1" in ${languageArray[*]} ]; then
        SystemUpdate dist-upgrade
    fi

    ExitScript "Complete!"
else
    ExitScript "You didn't do anything!'"
fi   




# LANGUAGE      UPDATED     VERSION     RESOURCE
# --------      --------    -------     --------
# Ada           11-22-16    Repository  http://www.radford.edu/~nokie/classes/320/compileInstall.html
# C             11-21-16    Repository  Standard package
# cobol         11-22-16    2.0rc-2     https://sourceforge.net/p/open-cobol/wiki/Install%20Guide/
# C++           11-21-16    Repository  Standard package
# Dart          11-21-16    Current     https://www.dartlang.org/install/linux
# Fortran       11-22-16    Current     https://gcc.gnu.org/wiki/GFortranBinaries
# Go            11-21-16    Current     https://golang.org/doc/install
# Haskell       11-21-16    Repository  https://www.haskell.org/downloads
# Haxe          11-22-16    Current     http://old.haxe.org/download/manual_install#packages
# LaTeX         11-22-16    Repository  http://www.latex-project.org/get/ & http://www.tug.org/texlive/quickinstall.html
# Lisp          11-22-16    Repository  http://clisp.org/
# Lua           11-21-16    5.3         https://www.lua.org/download.html & https://www.lua.org/manual/5.3/readme.html
# Java          11-21-16    8.X         https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
# Node.js       11-21-16    Current     https://nodejs.org/en/download/package-manager/
# Pascal        11-22-16    Repository  http://fusharblog.com/installing-free-pascal-in-ubuntu/ & http://www.freepascal.org/download.var
# Prolog        11-22-16    Repository  http://www.swi-prolog.org/build/Debian.html
# Python        11-22-16    3.5.2       https://docs.python.org/3.5/using/unix.html#getting-and-installing-the-latest-version-of-python           
# R             11-21-16    Repository  https://cran.r-project.org/doc/FAQ/R-FAQ.html#How-can-R-be-obtained_003f;;
# Ruby          11-21-16    Repository  https://www.ruby-lang.org/en/documentation/installation/#apt
# Rust          11-21-16    Current     https://www.rust-lang.org/en-US/downloads.htmlfor
# Swift         11-22-16 	3.0.1        https://swift.org/download/#using-downloads & https://swift.org/download/#releases
# Tcl/Tk        11-21-16    8.5         http://docs.activestate.com/activetcl/8.5/at.install.html
# Yorick        11-21-16    Repository  http://dhmunro.github.io/yorick-doc/downloads.html


# PACKAGE       UPDATED     VERSION     RESOURCE
# --------      --------    --------    --------
# Qt            11-21-16    Repository  https://wiki.qt.io/Install_Qt_5_on_Ubuntu