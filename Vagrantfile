# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Enable serial console
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--uart1", "0x3f8", "4"]
    vb.customize ["modifyvm", :id, "--uartmode1", "server", "tty"]
  end
end
