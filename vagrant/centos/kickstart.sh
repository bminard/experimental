#!/bin/sh
#-------------------------------------------------------------------------------
# centos: kickstart.sh
#
# Provision Kickstart configuration file.
#-------------------------------------------------------------------------------
# Copyright (C) 2016 Brian Minard
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


readonly PLAINTEXT_ROOT_PASSWORD=`cat ${ROOT_PASSWORD}`
readonly ENCRYPTED_ROOT_PASSWORD=`echo "from passlib.hash import sha512_crypt; print sha512_crypt.encrypt('${PLAINTEXT_ROOT_PASSWORD}')" | python -`
if [ -z "${ENCRYPTED_ROOT_PASSWORD}" ]; then
	exit 1
fi


cat<<_EOF
install
text
cdrom
skipx
lang en_US.UTF-8
keyboard us
timezone UTC
rootpw --iscrypted ${ENCRYPTED_ROOT_PASSWORD}
user --name=vagrant
auth --enableshadow --passalgo=sha512 --kickstart
firewall --disabled
selinux --permissive
bootloader --location=mbr
zerombr
clearpart --all --initlabel
autopart
firstboot --disable
reboot

# Keep this package list short to avoid SSH timeouts during Vagrant Box
# creation. Use the Packer template to install additional packages.
%packages --instLangs=en_US.utf8 --nobase --ignoremissing --excludedocs
openssh-server
openssh-clients
%end

%post --log=/root/ks.log

cat <<EOF > /etc/sudoers.d/vagrant
vagrant ALL=(ALL) NOPASSWD: ALL
Defaults:vagrant !requiretty
EOF
chmod 0440 /etc/sudoers.d/vagrant

mkdir -pm 700 /home/vagrant/.ssh
cat <<EOK >/home/vagrant/.ssh/authorized_keys
`cat ${VAGRANT_PUBLIC_KEY}`
EOK
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant.vagrant /home/vagrant/.ssh
%end
_EOF
