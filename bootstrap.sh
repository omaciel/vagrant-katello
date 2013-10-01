#!/usr/bin/env bash

# Disable firewall
service firewalld stop
chkconfig firewalld off

# Configure the katello nightly repos
rpm -Uvh http://fedorapeople.org/groups/katello/releases/yum/nightly/Fedora/19/x86_64/katello-repos-latest.rpm

# Installation of packages
yum install -y katello-all

# Add some useful packages
yum install -y net-tools
yum update -y vim-minimal
yum install -y vim-enhanced

# https://bugzilla.redhat.com/show_bug.cgi?id=1011716
yum update -y selinux-policy-targeted

# Configure the hostname
IP=`ifconfig | grep broadcast | awk -F ' ' '{print $2}'`
echo "$IP vagrant-fedora-19 vagrant-fedora-19.vagrantup.com" >> /etc/hosts
echo "HOSTNAME=vagrant-fedora-19.vagrantup.com" > /etc/sysconfig/network
hostname vagrant-fedora-19.vagrantup.com

# Configure katello
katello-configure --user-pass admin

# Keep SELinux off after a reboot
sed -i -e 's/^SELINUX=*/SELINUX=permissive/' /etc/selinux/config
