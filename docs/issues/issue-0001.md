# Setting Up Visual Studio Project To Work In Windows & WSL2

* Need to develop Vagrantfile in Microsoft Windows environment because Oracle VirtualBox runs in Windows
* Want to use WSL2 environment to work with Linux containers that have Ruby development tools
* Storing project files in WSL2 file system makes Vagrant for Windows or VirtualBox for Windows not happy
* Storing project files in Windows make Visual Studio Code dev container not happy