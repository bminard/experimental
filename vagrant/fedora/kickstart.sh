#!/bin/sh
#-------------------------------------------------------------------------------
# fedora: kickstart.sh
#
# Provision Kickstart configuration file.
#-------------------------------------------------------------------------------
# Copyright (C) 2016  Brian Minard
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
function usage {
	echo "Usage: ${0} --rootpw <password> <vagrant public ssh key>"
	exit 1
}


ROOT_PASSWORD=""
while [[ $# -gt 2 ]]; do
	key="$1"
	case $key in
		--rootpw)
			ROOT_PASSWORD="$2"
			shift
			;;
		*)
			usage
			;;
	esac
	shift
done
readonly VAGRANT_PUBLIC_KEY=${1}; shift


[ -f ${ROOT_PASSWORD} ] \
	&& [ -f ${VAGRANT_PUBLIC_KEY} ] \
	|| usage


readonly SALT="\$6\$"`openssl rand -hex 8`
readonly PLAINTEXT_ROOT_PASSWORD=`cat ${ROOT_PASSWORD}`
readonly ENCRYPTED_ROOT_PASSWORD=`echo "import crypt,getpass; print crypt.crypt('${PLAINTEXT_ROOT_PASSWORD}', '${SALT}')" | python -`


cat<<_EOF
# For more information on kickstart syntax and commands, refer to the
# Fedora Installation Guide:
# https://docs.fedoraproject.org/en-US/Fedora/13/html/Installation_Guide/sn-automating-installation.html
#
# For testing, you can fire up a local http server temporarily.
# cd to the directory where this ks.cfg file resides and run the following:
#    $ python -m SimpleHTTPServer
# You don't have to restart the server every time you make changes.  Python
# will reload the file from disk every time.  As long as you save your changes
# they will be reflected in the next HTTP download.  Then to test with
# a PXE boot server, enter the following on the PXE boot prompt:
#    > linux text ks=http://<your_ip>:8000/ks.cfg

# Required settings
lang en_US.UTF-8
keyboard 'us'
#rootpw --iscrypted ${ENCRYPTED_ROOT_PASSWORD}
rootpw ${ROOT_PASSWORD}
user --name=vagrant
auth --enableshadow --passalgo=sha512 --kickstart
timezone UTC

# Optional settings
install
text
cdrom
network --bootproto=dhcp
selinux --disabled
firewall --enabled --ssh

# Avoiding warning message on Storage device breaking automated generation
bootloader --location=mbr
zerombr

# The following is the partition information you requested
# Note that any partitions you deleted are not expressed
# here so unless you clear all partitions first, this is
# not guaranteed to work
clearpart --all --initlabel

autopart

# Does not support https.
repo --name=base --baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/13/Everything/i386/os/
url --url="http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/13/Everything/i386/os/"
skipx

services --enabled network
reboot

%packages --nobase --excludedocs
openssh-server
openssh-clients
%end

%post --log=/root/ks.log

# Give Vagrant user permission to sudo.
echo 'Defaults:vagrant !requiretty' > /etc/sudoers.d/vagrant
echo '%vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant

mkdir -pm u+rwx,og-rwx /home/vagrant/.ssh
cat <<EOK >/home/vagrant/.ssh/authorized_keys
`cat ${VAGRANT_PUBLIC_KEY}`
EOK
chmod u+rw-x,og-rwx /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
%end
_EOF
