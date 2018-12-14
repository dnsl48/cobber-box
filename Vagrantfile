ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.disksize.size = '120GB'
  config.vm.hostname = "192.168.100.1.nip.io"
  config.vm.post_up_message = "Open SilverStripe Box is up and running"

  config.ssh.forward_agent = true

  config.vagrant.plugins = { "vagrant-nfs_guest" => { "version" => "1.0.0" },   ## 1.0.2 and 1.0.3 are buggy and do not work on CentOS
                             "vagrant-disksize" => { "version" => "0.1.3" }
                           }

  config.vm.synced_folder '~', '/home/vagrant', type: "rsync", rsync__args: ["-r", "-L", "--ignore-missing-args", "--include=/.gitconfig", "--exclude=*"]
  config.vm.synced_folder '~', '/home/vagrant', type: "rsync", rsync__args: ["-r", "-L", "--ignore-missing-args", "--include=/.gitignore", "--exclude=*"]

  config.vm.synced_folder '~', '/home/vagrant/host/home'
  config.vm.synced_folder 'docker/', '/home/vagrant/docker'
  if Vagrant.has_plugin?("vagrant-nfs_guest")
    config.vm.synced_folder 'bench/', '/home/vagrant/bench', type: 'nfs_guest'
  else
    config.vm.synced_folder 'bench/', '/home/vagrant/bench', type: 'smb'
  end

  config.vm.network "private_network", ip: "192.168.100.1"

  config.vm.provider "virtualbox" do |vbox|
    vbox.name = "Open SilverStripe contributor box"
    vbox.cpus = 4
    vbox.memory = 8129
  end

  config.trigger.after :up do |trigger|
    trigger.info = "Patching network"
    trigger.run_remote = {path: "provision/00-network.sh"}
  end

  config.vm.provision "shell", path: "provision/00-host-configs.sh"
  config.vm.provision "shell", path: "provision/00-guest-configs.sh"
  config.vm.provision "shell", path: "provision/00-network.sh"
  config.vm.provision "shell", path: "provision/00-selinux.sh"
  config.vm.provision "shell", path: "provision/10-yum.sh"
  config.vm.provision "shell", path: "provision/20-cache.sh"
  config.vm.provision "shell", path: "provision/30-dnsmasq.sh"
  config.vm.provision "shell", path: "provision/40-docker.sh"
end
