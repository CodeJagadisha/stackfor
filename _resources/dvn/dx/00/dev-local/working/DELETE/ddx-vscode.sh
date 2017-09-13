# Install RVM - move external
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 |& tee $HOME/DevenDX/Logs/rvm-gpg.log
#\curl -sSL https://get.rvm.io | bash -s stable |& tee $HOME/DevenDX/Logs/rvm-install.log

# Install VSCode - move external
#sudo apt-get install -y libnss3
#wget -P $HOME/DevenDX/Applications/VSCode http://aprettycoolprogram.com/deven/dx/00/packages/vscode.tar
#cd $HOME/DevenDX/Applications/VSCode
#tar -xvf vscode.tar |& tee $HOME/DevenDX/Logs/untar-vscode.log
#cd


# Disable apt-get suggested and recommended packages
#wget -O ~/DevenDX/Resources/apt.conf http://aprettycoolprogram.com/deven/dx/00/packages/apt.conf |& tee $HOME/DevenDX/Logs/apt-disablesuggested.log
#pushd $HOME/DevenDX/Resources
#sudo cp apt.conf /etc/apt/