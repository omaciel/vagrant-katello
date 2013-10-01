#!/usr/bin/env bash

# Turn off SELinux
setenforce 0

# Disable firewall
service firewalld stop
chkconfig firewalld off

# Update system
yum install -y net-tools vim-enhanced

# Configure the katello nightly repos
rpm -Uvh http://fedorapeople.org/groups/katello/releases/yum/nightly/Fedora/19/x86_64/katello-repos-latest.rpm

# Installation of packages
yum install -y katello-all

# https://bugzilla.redhat.com/show_bug.cgi?id=1011716
yum update -y selinux-policy-targeted

# Configure the hostname
IP=`ifconfig | grep broadcast | awk -F ' ' '{print $2}'`
echo "$IP vagrant-fedora-19 vagrant-fedora-19.vagrantup.com" >> /etc/hosts
hostname vagrant-fedora-19.vagrantup.com

# Configure katello
katello-configure --user-pass admin

# Keep SELinux off after a reboot
sed -i -e 's/^SELINUX=*/SELINUX=permissive/' /etc/selinux/config
