$script = <<SCRIPT
if ! egrep -q '^COMPOSER_HOME' /etc/environment; then
  echo 'COMPOSER_HOME="/home/vagrant"' >> /etc/environment
fi
SCRIPT

Vagrant.configure("2") do |config|

    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    config.vm.network :private_network, ip: "192.168.33.101"
    config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--name", "vagrantee-symfony"]
  end

    config.vm.synced_folder "./application/test/", "/vagrant", id: "vagrant-root", :nfs => true

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "vagrantee/puppet/manifests"
        puppet.module_path = "vagrantee/puppet/modules"
        puppet.options = ['--verbose']
    end

end