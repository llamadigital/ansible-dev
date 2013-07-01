## My Ansible Playbooks for Dev

1. Install ansible and virtualbox. 
2. Clone this is to a tasks directory then configure the project.
3. Then run vagrant up ...

This is not the best practice dir structure as recommended by ansible, but it is
all I need for my dev boxes at the moment.

## Example Vagrantfile

    Vagrant.configure('2') do |config|
      config.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box'
      config.vm.box = 'raring-server-cloudimg-amd64-vagrant-disk1.box'
      config.vm.network :private_network, ip: '192.168.1.1'
    
      config.vm.hostname = 'dev'
      config.vm.synced_folder '../..', '/home/vagrant/source', :nfs => true
      config.vm.synced_folder '~/.ssh', '/home/vagrant/ssh'
      config.vm.synced_folder '~/dotfiles', '/home/vagrant/dotfiles'
    
      config.vm.provider :virtualbox do |vb|
        vb.customize ['modifyvm', :id, '--name', 'development', '--cpus', '1', '--memory', 512]
      end
    
      config.vm.provision :ansible do |ansible|
        ansible.playbook = 'playbook.yml'
        ansible.inventory_file = 'vagrant_host'
        ansible.verbose = true
      end
    
      config.vm.provision :shell, :path => 'tasks/install.sh'
    end

## Example playbook.yml

    ---
     - include: tasks/locale.yml

     - hosts: vagrant
       sudo: yes
    
       tasks:
         - include: tasks/vagrant.yml
         - include: tasks/ide.yml
         - include: tasks/the_silver_searcher.yml
         - include: tasks/ruby.yml
         - include: tasks/rails.yml
         - include: tasks/nodejs.yml
         - include: tasks/postgresql.yml
    
     - include: tasks/phantomjs.yml

## Example vagrant_host

    [vagrant]
    192.168.1.1
    
## TODO

1. turn on query logging on the databases (for dev)
