# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "fedora-19"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/86066173/fedora-19.box"

  config.vm.network :forwarded_port, guest: 80, host: 80, auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 443, auto_correct: true

  config.vm.provision :shell, :path => "bootstrap.sh"
end
