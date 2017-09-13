Deven
Scratchpad
==========

shell script:
    in $HOME/Scripts/sh
    compresses development version of dvn.py and puts in development w/timestamp


    
FINAL BUILDS
------------
    Update all documentation, motd, etc
    Build CLI
    Build GUI
        startx


        
HAT: H ADVANCED TECHNOLOGY

Rename VBox share from "Development" to "HostShare"

versions of python, perl, gcc


build scripts
  remove all log files (system, etc)
  stuff from scripts
  Can we remove?
	sudo apt-get purge -y gettext-base
  Need to add?
	build-essential?

  

DVN

  python3-dev
  virtualenv
  RVM

	- openssh-server
	- zip
	- unzip
	- emacs
	- curl
	- vim

	- iceweasel
	- xfce4-terminal?

dvn refresh
  update
  upgrade
  autoclean
  autoremove

dvn optimize
  ??  
  
dvn cleanup
    stuff from scripts
    remove system log files
    debfoster
    deborphan

Or you can use dpkg to list the current package selections (the desired state of either installed or to be installed packages): 


dpkg --get-selections

And store the list of software to a file called /backup/package-selections 


dpkg --get-selections >/backup/package-selections

You can also find package information in the next directories (you can use mc or other FileManager to browse them): 

•/var/lib/apt/lists/* 


•/var/lib/dpkg/available: list of available packages from repositories. 


•/var/lib/dpkg/status: status of installed (and available) packages. This file contains information about whether a package is marked for removal or not, whether it is installed or not, etc. A package marked reinst-required is broken and requires reinstallation. 




Restore installed software

After re-installing base system you can immediately re-install all software. You need dselect: 


apt-get install dselect

Then you have to type following command: 


dpkg --set-selections </backup/package-selections

Now that your list is imported use apt-get, Synaptic or other PackageManagement tools. To install the packages: 


apt-get dselect-upgrade

All this with a single command: 


aptitude install $(cat /backup/package-selections | awk '{print $1}')

	
	
	
LIST OF STANDARD SYSTEM UTILITIES	
 apt-listchanges
 lsof
 mlocate
 w3m
 at
 libswitch-perl
 xz-utils
 telnet
 dc
 bsd-mailx
*file
 exim4-config
 m4
 bc
 dnsutils
 exim4
*python2.7
 openssh-client
 aptitude
*bash-completion
 python
*host
 install-info
*bzip2
 reportbug
 krb5-locales
 bind9-host
*time
*info
 liblockfile-bin
 whois
 aptitude-common
*patch
 ncurses-term
 mutt
 mime-support
 exim4-daemon-light
 ftp
 nfs-common
 python-reportbug
 rpcbind
 texinfo
 python-minimal
 procmail
 libclass-isa-perl
 python-apt
 python-support
 exim4-base
 debian-faq
 doc-debian


    
    
DevenDX
-------



* zip up software to ftp  
    
Autologin

https://en.wikipedia.org/wiki/Xfce#Mousepad

https://en.wikipedia.org/wiki/List_of_text_editors


https://l3net.wordpress.com/2014/03/03/lightweight-debian-lxde-desktop-from-scratch-part-2/


debootstrap --variant=minbase.

https://wiki.debian.org/VirtualBox#Debian_8_.22Jessie.22




echo 0 > /var/log/log_file_name



You can remove all logs file using script on command line 

 for logs in `find /var/log -type f`; do > $logs; done

 or save this in to some file like zerolog.sh and 

 chmod +x zerolog.sh

 execute the script

 ./zerolog.sh

 

 
 
 
 Log files from the system and various programs/services, especially login (/var/log/wtmp which logs all logins and logouts into the system) and syslog (/var/log/messages, where all kernel and system program message are usually stored). Files in /var/log can often grow indefinitely, and may require cleaning at regular intervals. Something that is now normally managed via log rotation utilities such as 'logrotate'. This utility also allows for the automatic rotation compression, removal and mailing of log files. Logrotate can be set to handle a log file daily, weekly, monthly or when the log file gets to a certain size. Normally, logrotate runs as a daily cron job. This is a good place to start troubleshooting general technical problems.
 
 
 
 Linux FAQ

Azure VM Issues

I'm getting a "Running without the SUID sandbox" error?

Unfortunately, this is a known issue that we're still investigating.

Debian and Moving Files to Trash

If you see an error when deleting files from the VS Code Explorer on the Debian operating system, it might be because the trash implementation that VS Code is using is not there.

Run these commands to solve this issue:
sudo apt-get install gvfs-bin


error ENOSPC

When you see this error, it indicates that the VS Code file watcher is running out of handles. The current limit can be viewed by running:
cat /proc/sys/fs/inotify/max_user_watches


The limit can be increased to its maximum by editing /etc/sysctl.conf and adding this line to the end of the file:
fs.inotify.max_user_watches=524288


The new value can then be loaded in by running sudo sysctl -p. Note that Arch Linux works a little differently, view this page for advice.

While 524288 is the maximum number of files that can be watched, if you're in an environment that is particularly memory constrained, you may wish to lower the number. Each file watch takes up 540 bytes (32-bit) or ~1kB (64-bit), so assuming that all 524288 watches are consumed that results in an upperbound of around 256MB (32-bit) or 512MB (64-bit).
