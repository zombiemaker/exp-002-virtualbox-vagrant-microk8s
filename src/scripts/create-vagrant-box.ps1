
vagrant package --base vagrant-box-ubuntu-server-20.04

vagrant box add --provider virtualbox --name zombiemaker/ubuntu-server-20.04-x64 package.box