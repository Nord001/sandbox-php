Vagrant.configure("2") do |config|

    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    config.vm.network :private_network, ip: "192.168.33.101"
    config.ssh.forward_agent = true

    #############################################################
    # Ansible provisioning (you need to have ansible installed)
    #############################################################

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrantee/ansible/provision.yml"
        ansible.inventory_path = "vagrantee/ansible/inventory_default"
    end

    #############################################################
    # Puppet provisioning
    #############################################################
    #config.vm.provision :puppet do |puppet|
    #    puppet.manifests_path = "vagrantee/puppet/manifests"
    #    puppet.module_path = "vagrantee/puppet/modules"
    #    puppet.options = ['--verbose']
    #end

    config.vm.synced_folder "./application/test/", "/vagrant", id: "vagrant-root", :nfs => true
end