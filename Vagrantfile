ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "ss"

  config.vm.post_up_message = "OpenSilverStripe Box is up and running"

  config.ssh.forward_agent = true

  config.vagrant.plugins = {"vagrant-nfs_guest" => {"version" => "1.0.0"}, ## 1.0.2 and 1.0.3 are buggy and do not work on CentOS
                            #                            "landrush" => {"version" => "1.3.0"},
                            "vagrant-disksize" => {"version" => "0.1.3" }
                           }

  # config.vm.synced_folder '~/.gitconfig', '/home/vagrant/.gitconfig'
  config.vm.synced_folder 'docker/', '/home/vagrant/docker'
  if Vagrant.has_plugin?("vagrant-nfs_guest")
    config.vm.synced_folder 'bench/', '/home/vagrant/bench', type: 'nfs_guest'
  else
    config.vm.synced_folder 'bench/', '/home/vagrant/bench', type: 'smb'
  end

  if Vagrant.has_plugin?("landrush")
    # config.landrush.upstream '8.8.8.8'
    # config.landrush.enabled = true
    # config.landrush.tld = 'ss'
    # config.landrush.host 'test.ss', '192.168.100.42'
  end

  config.vm.network "private_network", ip: "192.168.100.42"

  config.vm.provision "shell", path: "provision/00-network.sh"
  config.vm.provision "shell", path: "provision/00-selinux.sh"
  config.vm.provision "shell", path: "provision/10-yum.sh"
  config.vm.provision "shell", path: "provision/20-cache.sh"
  config.vm.provision "shell", path: "provision/30-dnsmasq.sh"
  config.vm.provision "shell", path: "provision/40-docker.sh"

  # config.vm.network
  # config.vm.provider
  # config.vm.provision

  config.vm.provider "virtualbox" do |vbox|
    vbox.name = "oss box 2"
    vbox.cpus = 12
    vbox.memory = 8129
  end

  config.disksize.size = '120G'
end
