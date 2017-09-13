Deven v00.90.00-160320
Build documentation
===================

CREATING DVNBS
--------------
Create a new VirtualBox virtual machine
	* 15GB Dynamic HDD
	* Enable Shared Clipboard & Drag'n'Drop as Bidirectional
	* 2GB RAM
	* 1 CPU
  * Enable PAE/NX
	* 128MB VRAM
  * Disable audio
	* Shared host folder for development, set to auto-mount
  * Point snapshots location to same folder as .vdi
	
Install Debian 8.3.0
	* Expert install, accepting defaults except:
      - Hostname = "Deven"
      - Shadow passwords = "No"
      - Allow login as root = "No"
      - User fullname = "deven"
      - Username = "deven"
      - Password = "deven"
      - initrd drivers = "targeted"
      - Use non-free software = "Yes"
      - Allow backported software
      - Unselect everything in tasksel

Add "deven" to sudoers
	visudo
	Add to end "deven ALL=(ALL) NOPASSWD: ALL"

Mount the VirtualBox Guest Tools CD and reboot
	Devices > Insert...

Build DNVBS
	wget http://deven.aprettycoolprogram.com/dx/00/bld/build-dvnbs.sh
	chmod +x build-dvnbs.sh
	./build-dvnbs.sh

Reduce the size of the .vdi file (in the Windows host)
    VBoxManage.exe modifyhd c:\path\to\thedisk.vdi --compact
  
DVNBS has now been built!