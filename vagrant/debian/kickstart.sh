#!/bin/sh


# Provision Kickstart configuration file.


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
choose-mirror-bin mirror/http/proxy string
d-i apt-setup/use_mirror boolean true
d-i base-installer/kernel/override-image string linux-server
d-i clock-setup/utc boolean true
d-i clock-setup/utc-auto boolean true
d-i finish-install/reboot_in_progress note
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i grub-installer/bootdev  string /dev/sda
d-i keymap select us
d-i mirror/country string manual
d-i mirror/http/directory string /debian
d-i mirror/http/hostname string http.debian.net
d-i mirror/http/proxy string
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman-auto/method string lvm
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-lvm/device_remove_lvm boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/confirm_write_new_label boolean true
d-i passwd/root-login boolean false
d-i passwd/root-password-crypted password ${ENCRYPTED_ROOT_PASSWORD}
d-i passwd/user-fullname string vagrant
d-i passwd/user-uid string 900
d-i passwd/user-password password
d-i passwd/username string vagrant
d-i pkgsel/include string openssh-server sudo bzip2 acpid cryptsetup zlib1g-dev wget curl dkms make nfs-common
d-i pkgsel/install-language-support boolean false
d-i pkgsel/update-policy select unattended-upgrades
d-i pkgsel/upgrade select full-upgrade
# Prevent packaged version of VirtualBox Guest Additions being installed:
d-i preseed/early_command string sed -i '/in-target/idiscover(){/sbin/discover|grep -v VirtualBox;}' /usr/lib/pre-pkgsel.d/20install-hwpackages
d-i time/zone string UTC
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false
d-i preseed/late_command string sed -i '/^deb cdrom:/s/^/#/' /target/etc/apt/sources.list
apt-cdrom-setup apt-setup/cdrom/set-first boolean false
apt-mirror-setup apt-setup/use_mirror boolean true
popularity-contest popularity-contest/participate boolean false
tasksel tasksel/first multiselect standard, ubuntu-server
_EOF
