sandbox-php
===========

This is a basic PHP sandbox with:
 - Nginx+PHP5-fpm OR Apache+PHP (default is Nginx)
 - MySQL
 - Composer
 - Configurable system packages and PHP modules

Provisioning is available with:
 - Ansible
 - Puppet
 
Where Ansible is the default. To change to other provisioner, just edit the Vagrantfile and comment / uncomment the necessary blocks.

After provisioning with `vagrant up`, the VM will be live at 192.168.33.101 (you can access it through your browser and you should see a phpinfo() output).

###Note about Ansible
You'll need to install `ansible` before you can use this provisioner.
Ubuntu users: you can use this ppa: https://launchpad.net/~rquillo/+archive/ansible.

###Note about NFS for Ubuntu users
You'll need to install `nfs-common` and `nfs-kernel-server`.
