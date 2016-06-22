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


[ "${ROOT_PASSWORD}" != "" ] \
	&& [ -f ${VAGRANT_PUBLIC_KEY} ] \
	|| usage


readonly SALT="\$6\$"`openssl rand -hex 8`
readonly ENCRYPTED_ROOT_PASSWORD=`echo "import crypt,getpass; print crypt.crypt('${ROOT_PASSWORD}', '${SALT}')" | python -`


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

%packages --instLangs=en_US.utf8 --nobase --ignoremissing --excludedocs

openssh-clients
sudo
kernel-headers
kernel-devel
gcc
make
perl
curl
wget
nfs-utils
net-tools
vim-minimal
bzip2
-fprintd-pam
-intltool
-mariadb-libs
-postfix
-linux-firmware
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl105-firmware
-iwl135-firmware
-iwl1000-firmware
-iwl2030-firmware
-iwl2000-firmware
-iwl3060-firmware
-iwl3160-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6000g2b-firmware
-iwl6050-firmware
-iwl7260-firmware
-libertas-sd8686-firmware
-libertas-sd8787-firmware
-libertas-usb8388-firmware
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware
%end


%post --log=/root/ks.log

echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
echo "Defaults:vagrant !requiretty" >> /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
mkdir -pm 700 /home/vagrant/.ssh
#curl -o /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
cat <<EOK >/home/vagrant/.ssh/authorized_keys
`cat ${VAGRANT_PUBLIC_KEY}`
EOK
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant.vagrant /home/vagrant/.ssh
yum -y update
yum -y remove linux-firmware
%end
_EOF
