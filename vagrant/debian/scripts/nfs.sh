#!/bin/sh
#-------------------------------------------------------------------------------
# debian: nfs.sh
#
# Enable NFS.
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
set -x


function start {
	/bin/systemctl enable ${1} \
		&& /bin/systemctl start ${1} \
		&& /bin/systemctl status ${1} | egrep -q "Active: active"
	if [ $? -ne 0 ]; then
		exit 1
	fi
}


grep -q NFSD /boot/config-`uname -r`
if [ $? -ne 0 ]; then
	echo "No kernel support for NFS..."
	exit 1
fi
apt-get -y install nfs-kernel-server


start nfs-kernel-server
