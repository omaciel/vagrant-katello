#!/usr/bin/env bash

# Update system
yum update -y

# Configure the katello nightly repos
rpm -Uvh http://fedorapeople.org/groups/katello/releases/yum/nightly/Fedora/18/x86_64/katello-repos-latest.rpm

# Installation of packages
yum install -y katello-all

# Rebuild VirtualBox Guest Additions. This is required whenever guest package
# manager updates the kernel. Reference:
# https://github.com/mitchellh/vagrant/issues/1657#issuecomment-20589841
#
# vagrant-vbguest plugin could be installed to automatically keep VirtualBox
# Guest Additions up to date. https://github.com/dotless-de/vagrant-vbguest
/etc/init.d/vboxadd setup

# Configure katello
katello-configure -b --user-pass admin

# Turn off SELinux
setenforce 0

# Keep SELinux off after a reboot
sed -i.old "s/^\(SELINUX=\)\(.*\)$/\1permissive/" /etc/selinux/config

# Disable firewall
systemctl disable firewalld.service
systemctl stop firewalld.service
