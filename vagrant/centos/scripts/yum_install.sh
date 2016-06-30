#!/bin/sh
#-------------------------------------------------------------------------------
# centos: yum_install.sh
#
# Install required packages using yum.
#-------------------------------------------------------------------------------
# Copyright (C) 2016 Brian Minard
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#-------------------------------------------------------------------------------
# minimum required packages to required for this Vagrant Box to function
#yum -y install epel-release
#yum -y install gcc make bzip2 kernel-headers kernel-devel dkms
# yum clean all
# mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
# sh /mnt/VBoxLinuxAdditions.run
# umount /mnt
# rm -f /home/vagrant/VBoxGuestAdditions.iso
yum --assumeyes install sudo
