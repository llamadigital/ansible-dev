= My Ansible PLaybooks for Dev =

= Example Vagrantfile =

    Vagrant::Config.run do |config|
      config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'
      config.vm.box = 'ubuntu-server-12042-x64-vbox4210-nocm'
      config.vm.network :hostonly, '192.168.1.1'
      config.vm.share_folder 'source', '/home/vagrant/source', '../..', :nfs => true
      config.vm.share_folder 'ssh', '/home/vagrant/ssh', '~/.ssh', :create => true
      config.vm.share_folder 'dotfiles', '/home/vagrant/dotfiles', '~/dotfiles', :create => true
      config.vm.customize ['modifyvm', :id, '--name', 'development', '--cpus', '1', '--memory', 512]
      config.vm.provision :ansible do |ansible|
        ansible.playbook = 'playbook.yml'
        ansible.inventory_file = 'vagrant_host'
        ansible.verbose = true
      end
      config.vm.provision :shell, :path => 'tasks/install.sh'
    end

= Example playbook.yml =

    ---
     - hosts: vagrant
       sudo: yes
    
       tasks:
         - include: tasks/vagrant.yml
         - include: tasks/ide.yml
         - include: tasks/the_silver_searcher.yml
         - include: tasks/ruby.yml
         - include: tasks/rails.yml
         - include: tasks/postgresql.yml
    
     - include: tasks/phantomjs.yml

= Example vagrant_host =

    [vagrant]
    192.168.69.70
