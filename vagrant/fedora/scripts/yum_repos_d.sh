#!/bin/sh


# Provision /etc/yum.repos.d with updated repository information.
# Required to enable yum.


readonly FEDORA_REPOSITORY=/etc/yum.repos.d/fedora.repo


cat<<_EOF > ${FEDORA_REPOSITORY}
[fedora]
name=Fedora \$releasever - \$basearch
baseurl=https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/\$releasever/Everything/\$basearch/os/
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-\$releasever&arch=\$basearch
enabled=1
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[fedora-debuginfo]
name=Fedora \$releasever - \$basearch - Debug
failovermethod=priority
baseurl=https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/\$releasever/Everything/\$basearch/debug/
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-debug-\$releasever&arch=\$basearch
mirrorlist=http://mirrors.fedoraproject.org/metalink?repo=fedora-debug-\$releasever&arch=\$basearch
enabled=0
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[fedora-source]
name=Fedora \$releasever - Source
failovermethod=priority
baseurl=https://dl.fedoraproject.org/pub/archive/fedora/linux/releases/\$releasever/Everything/\$basearch/source/SRPMS/
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-source-\$releasever&arch=\$basearch
enabled=0
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch
_EOF


chown root:root ${FEDORA_REPOSITORY}
chmod u+rw,og+r,uog-x ${FEDORA_REPOSITORY}
