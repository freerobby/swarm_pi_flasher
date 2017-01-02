Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|
  config.vm.box = "debian/jessie64"

  config.vm.network "private_network", ip: "10.1.1.1"

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "vvv"
    ansible.playbook = "bootstrap.yml"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096]
    vb.customize ["modifyvm", :id, "--cpus", 8]
    vb.customize ["modifyvm", :id, "--usb", "on"]

    # Connect Orion StarShoot Autoguider
    vb.customize ["usbfilter", "add", "0",
      "--name", "QHY5-CMOS",
      "--action","hold",
      "--target", :id,
      "--vendorid", "0x16c0",
      "--productid", "0x296d"
    ]
  end

  # VNC and Websockify for each XWindow Application
  (1..3).each do |display_port_suffix|
    vnc_port = 5900 + display_port_suffix
    websockify_port = 6100 + display_port_suffix
    config.vm.network "forwarded_port", guest: vnc_port, host: vnc_port
    config.vm.network "forwarded_port", guest: websockify_port, host: websockify_port
  end
  # NoVNC
  config.vm.network "forwarded_port", guest: 6080, host: 6080
  # pi_frontend
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  config.ssh.forward_agent = true
end
