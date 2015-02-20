# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "2048"
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision "shell", path: "_vagrant/init.sh"
end
