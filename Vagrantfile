ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "silverbox"
  config.vm.post_up_message = "SilverBox is up and running"

  config.ssh.forward_agent = true

  config.vagrant.plugins = { "vagrant-nfs_guest" => { "version" => "1.0.0" },   ## 1.0.2 and 1.0.3 are buggy and do not work on CentOS
                             # "vagrant-vbguest" => { "version" => "0.17.2" },
                           }

  if Vagrant.has_plugin? "vagrant-nfs_guest"
    BENCH_MOUNT_TYPE = 'nfs_guest'
  else
    BENCH_MOUNT_TYPE = 'smb'
  end

  config.vm.provider "virtualbox" do |vbox|
    vbox.name = "silverbox"
    vbox.cpus = 4
    vbox.memory = 6144

    if BENCH_MOUNT_TYPE == 'nfs_guest' then
      unless File.exist?('./bench.vdi')
        vbox.customize ['createmedium', 'disk', '--filename', './bench.vdi', '--variant', 'Standard', '--format', 'VDI', '--size', 120 * 1024]
      end
      # TODO: detach the image if cmd is `vagrant destroy` as it deletes the storages...
      vbox.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './bench.vdi']
    end
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder '~', '/home/vagrant/host/home'
  config.vm.synced_folder 'docker/', '/home/vagrant/docker'

  config.vm.synced_folder 'bench/', '/home/vagrant/bench', type: BENCH_MOUNT_TYPE

  config.vm.network "private_network", ip: "192.168.10.10"

  config.trigger.after :up do |trigger|
    trigger.info = "Patching network"
    trigger.run_remote = {path: "provision/00-network.sh"}
  end

  if BENCH_MOUNT_TYPE == 'nfs_guest' then
    config.vm.provision "shell", path: "provision/00-bench-sda1-btrfs.sh"
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
