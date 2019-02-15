# Troubleshooting

### Filesystem is not responding after I shut down the box through Virtualbox

If you shutdown the server through Virtualbox UI, then your host filesystem may
try to keep communicating with the NFS server, which is down. You'll have to
We use `nfs_guest` plugin, which makes the NFS server out of vagrant box and your
host machine mounts the `bench` folder through NFS.

First you'll need to determine which NFS folders are still mounted on your host
machine. To do so run the command:

```bash
mountstats
```

Then you can manually unmount each folder from the list with the following command:

```bash
sudo umount -f -l /.../silverbox/bench
```

### The filesystem on the host machine becomes slow

If you use nfs, smb or nfs_guest as transport you may start experiencing the filesystem slowing
down when the `bench` folder grows bigger than 10GB. A potential solution to delete something
or start using another box (you could even do it in parallel with another IP address, different from 192.168.10.10).

### Run behat on your local browser

You'll need to run chromedriver on your host machine with the following command

```bash
chromedriver --port=9515 --whitelisted-ips="192.168.10.10,127.0.0.1"
```

Then you'll need to patch your `behat.yml` to connect to the chromedriver on your host machine.
You'll need to find `wd_host` key and update its value to use the vagrant host
(which passes the port 9515 to the host machine through an ssh tunnel) like so:

```yml
wd_host: "http://vagrant:9515" #chromedriver port
```

### Run behat tests within the box with headless chrome

```yml
wd_host: "http://chrome:4444" #chromedriver port
```

### Vagrant `up` partially failed and now you cannot `halt` the box

Even if `vagrant halt` gives you an error, you still can shut down the box through `Virtualbox UI`.

### Vagrant failed to initialize at a very early stage

If you just updated Virtualbox and now you cannot run the box with an error message about plugins

```
Vagrant failed to initialize at a very early stage:                  
                                                                        
The plugins failed to initialize correctly. This may be due to manual
modifications made within the Vagrant home directory. Vagrant can    
attempt to automatically correct this issue by running:              
                                                                         
  vagrant plugin repair                                           
                                                                                          
If Vagrant was recently updated, this error may be due to incompatible                                
versions of dependencies. To fix this problem please remove and re-install                       
all plugins. Vagrant can attempt to do this automatically by running:                                                 
                                                                                                                         
  vagrant plugin expunge --reinstall                                                                                  
                                                                                                                                  
Or you may want to try updating the installed plugins to their latest                                                
versions:                                                                                              
                                                                                                    
  vagrant plugin update                                                                                         
                                                                                                          
Error message given during initialization: Unable to resolve dependency: user requested 'vagrant-nfs_guest (= 1.0.0)'
```

Then you may need to expunge the plugins locally:


```bash
$ vagrant plugin expunge --force --local
```
