#!/bin/bash
# DevenDX Python Installer - v00.90.02.160313 - http://deven.aprettycoolprogram.com

#function InstallPython(){
#	clear
#    answer=""
#	while [[ $answer != [YyNn] ]]; do
#		printf "\n"
#		AskQuestion "Install Python 3.4.4? ${y}Y/N${n} "
#	done
#	if [[ $answer = [Yy] ]]; then
#		wget -P $HOME/DevenDX/Resources http://aprettycoolprogram.com/deven/dx/00/packages/python-3.4.4.tgz |& tee $HOME/DevenDX/Logs/python3-wget.log
#		cd $HOME/DevenDX/Resources
#		tar -xzvf python-3.4.4.tgz |& tee $HOME/DevenDX/Logs/untar-python3.log
#		cd $HOME/DevenDX/Resources/Python-3.4.4
#		./configure |& tee $HOME/DevenDX/Logs/python3-configure.log
#		make |& tee $HOME/DevenDX/Logs/python3-make.log
#		make test |& tee $HOME/DevenDX/Logs/python3-maketest.log
#		make install |& tee $HOME/DevenDX/Logs/python3-makeinstall.log
#		cd
#	fi
#}