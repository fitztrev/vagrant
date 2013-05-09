# -*- mode: ruby -*-
# vi: set ft=ruby :

# All settings are in `boxes.json`. Let's start by parsing that
boxes = JSON.parse(File.read('vagrant.json'), :symbolize_names => true)

###

Vagrant.configure("2") do |config|

	### Global ###

		# Set which box to use for our instances
		config.vm.box_url = boxes[:default][:box_url]

		if boxes[:default][:ssh_forward_agent]
			config.ssh.forward_agent = boxes[:default][:ssh_forward_agent]
		end

		# Run the default shell scripts that will be applied to all VMs
		if boxes[:default][:scripts]
			boxes[:default][:scripts].each do |script|
				config.vm.provision :shell, :path => script
			end
		end

		if boxes[:default][:synced_folders]
			boxes[:default][:synced_folders].each_pair do |host,guest|
				config.vm.synced_folder host.to_s, guest.to_s
			end
		end

	### Individual VMs ###

		## Start going through each of the boxes that we have listed and configure a VM
		boxes[:boxes].each_pair do |name,atts|
			config.vm.define name do |box|

				# Set the VM name and hostname
				box.vm.box = name.to_s
				box.vm.hostname = "%s.%s" % [name.to_s, boxes[:default][:domain]]
				box.vm.provider :virtualbox do |vb|
					vb.name = name.to_s
					if atts[:memory]
						vb.customize ["modifyvm", :id, "--memory", atts[:memory]]
					end
				end

				# If private IP specified, set it up
				if atts[:ip]
					box.vm.network :private_network, ip: atts[:ip]
				end

				# If port forwarding specified, set it up
				if atts[:forward]
					atts[:forward].each_pair do |host_port,guest_port|
						box.vm.network :forwarded_port, guest: guest_port.to_i, host: host_port.to_s.to_i
					end
				end

				# If any VM-specific scripts are specified, run them
				if atts[:scripts]
					atts[:scripts].each do |script|
						box.vm.provision :shell, :path => script
					end
				end

			end
		end

end
