# pie
#### Build development environments in Debian linux

*This project has moved:* https://github.com/APrettyCoolProgram/stackfor)

pie was a powerful, customizable scripting framework for Debian-based systems, originally for Raspberry Pi hardware.


---
This is the original README text for pie
---

Since pie scripts are normal shell scripts with some extra magic thrown in, if you can write shell scripts, you can write pie scripts.

And since pie scripts are magical, they instantly give your scripts special abilities. For instance, pie scripts **auto-generate their own help screens**, and can be **added to a manifest file for importing into pie**, so you can essentially mirror an environment.

And all of **the magic is created automatically**, so you can focus on writing code.

Here are some examples of how pie can be used:

	You type this...					...pie does this
	
	"pie python install"				"sudo apt-get install python3"
	"pie python install 2				"sudo apt-get install python"
	"pie python install 3.5.2 source"	Downloads the source for Python3.5.2 from python.org, and builds it
	"pie python use 2"					Python 2.x is now the default env
	"pie python use 3"					Python 3.x is now the default env
	

pie consists of three parts:

1. **piengine.sh**, the main logic for pie
2. **pie.sh**, the starting point for pie
3. **YOUR_SCRIPT_NAME_HERE.sh**, user-created scripts with magic!

The syntax for pie is *"pie SCRIPT ACTION [COMMANDS...]*

- The **script** is a pie script (i.e. "python.sh")
- The **action** is what you want to do (i.e. "install")
- The **commands** are optional arguments (i.e. "from-source")

There is one very special action that works with all pie scripts: *"help"*. pie auto-generates help content for your scripts, for example:

	Typing this...					...would display this
	"pie help"						A list of available pie scripts
	"pie python help"				A list of actions you can use with the python.sh script
	"pie python install help"		A list of commands that work with the install action for python.sh

To start using pie, just type the following at a command line: `wget http://aprettycoolprogram.com/pie/getpie.sh && chmod +x getpie.sh && ./getpie.sh`

That will install the latest stable version of pie, and the following pie scripts:

	ada			Installs the Ada programming language
	bakery		Creates new pie script templates
	c++			Installs the c++ programming language
	c			Installs the c programming language
	system		Performs various system-related functions
	vscode		Installs Visual Studio Code
