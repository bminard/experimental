#!/bin/sh
#-------------------------------------------------------------------------------
# fedora: kickstart.sh
#
# Provision /etc/yum.repos.d with updated repository information.
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
readonly FEDORA_REPOSITORY=/etc/yum.repos.d/fedora.repo
readonly FEDORA_UPDATES_REPOSITORY=/etc/yum.repos.d/fedora-updates.repo
readonly FEDORA_UPDATES_TESTING_REPOSITORY=/etc/yum.repos.d/fedora-updates-testing.repo


cat<<_EOF > ${FEDORA_REPOSITORY}
[fedora]
name=Fedora \$releasever - \$basearch
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/\$releasever/Everything/\$basearch/os/
enabled=1
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[fedora-debuginfo]
name=Fedora \$releasever - \$basearch - Debug
failovermethod=priority
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/\$releasever/Everything/\$basearch/debug/
enabled=0
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[fedora-source]
name=Fedora \$releasever - Source
failovermethod=priority
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/releases/\$releasever/Everything/\$basearch/source/SRPMS/
enabled=0
metadata_expire=7d
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch
_EOF


cat<<_EOF > ${FEDORA_UPDATES_REPOSITORY}
[updates]
name=Fedora \$releasever - \$basearch - Updates
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/\$releasever/\$basearch/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[updates-debuginfo]
name=Fedora \$releasever - \$basearch - Updates - Debug
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/\$releasever/\$basearch/debug/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[updates-source]
name=Fedora \$releasever - Updates Source
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/\$releasever/SRPMS/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch
_EOF


cat<<_EOF > ${FEDORA_UPDATES_TESTING_REPOSITORY}
[updates-testing]
name=Fedora \$releasever - \$basearch - Test Updates
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/testing/\$releasever/\$basearch/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[updates-testing-debuginfo]
name=Fedora \$releasever - \$basearch - Test Updates Debug
baseurl=http://dl.fedoraproject.org/pub/archive/fedora/linux/updates/testing/\$releasever/\$basearch/debug/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch

[updates-testing-source]
name=Fedora \$releasever - Test Updates Source
baseurl=http://download.fedoraproject.org/pub/fedora/linux/updates/testing/\$releasever/SRPMS/
enabled=0
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-\$basearch
_EOF


chown root:root ${FEDORA_REPOSITORY} ${FEDORA_UPDATES_REPOSITORY} ${FEDORA_UPDATES_TESTING_REPOSITORY} \
	&& chmod u+rw,og+r,uog-x ${FEDORA_REPOSITORY} ${FEDORA_UPDATES_REPOSITORY} ${FEDORA_UPDATES_TESTING_REPOSITORY}
