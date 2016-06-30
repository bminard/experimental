#!/bin/sh
#-------------------------------------------------------------------------------
# centos: ntp.sh
#
# Enable NTP.
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
	/usr/bin/systemctl enable ${1} \
		&& /usr/bin/systemctl start ${1} \
		&& /usr/bin/systemctl status ${1} | egrep -q "Active: active"
	if [ $? -ne 0 ]; then
		exit 1
	fi
}


yum --assumeyes install ntp


start ntpd
