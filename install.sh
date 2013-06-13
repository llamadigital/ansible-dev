#!/bin/bash

if [ -f /home/vagrant/.bashrc ] && [ ! -L /home/vagrant/.bashrc ]
then
  rm -fv /home/vagrant/.bashrc
fi
cp -fv /home/vagrant/ssh/id_rsa* /home/vagrant/.ssh
cp -fv /home/vagrant/ssh/config /home/vagrant/.ssh
chown -Rv vagrant:vagrant /home/vagrant/.ssh
