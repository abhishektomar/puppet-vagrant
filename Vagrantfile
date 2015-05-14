# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
config = YAML.load_file('VagrantConf.yml')

domain = "#{config['domain']}"
nodes = config['servers']

Vagrant.configure("2") do |config|
  nodes.each do |node,node_details|
    config.vm.define node do |node_config|
      node_config.vm.box = node_details['box']
      node_config.vm.box_url = 'http://files.vagrantup.com/' + node_config.vm.box + '.box'
      node_config.vm.hostname = node + '.' + domain
      node_config.vm.network :private_network, ip: node_details['ip']

      if node_details['fwdhost']
        node_config.vm.network :forwarded_port, guest: node_details['fwdguest'], host: node_details['fwdhost']
      end

      memory = node_details['ram'] ? node_details['ram'] : 512;
      puts memory
      node_config.vm.provider :virtualbox do |vb|
        vb.customize [
          'modifyvm', :id,
          '--name', node_details["node"],
          '--memory', memory.to_s
        ]
      end
      if node == 'puppet'
        config.vm.synced_folder node_config['host'], node_config['guest'],
        owner: "root", group: "root"
      end
      
      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'provision/manifests'
        puppet.module_path = 'provision/modules'
      end
    end
  end
end
