#-------------------------------------------------------------------------------
# vagrant: Makefile
#
# Makefile recipes for creating a Vagrant Box for various operating systems.
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
DEBIAN_VERSION?=8.4.0


.PHONY: all
all: check vagrant-boxes


.PHONY: check
check: debian-${DEBIAN_VERSION}-amd64-netinst.timestamp


.PHONY: vagrant-boxes
vagrant-boxes: debian-box


# Name the JSON file used by Packer after the ISO image it consumes.
debian-box: debian-${DEBIAN_VERSION}-amd64_virtualbox.box
debian-${DEBIAN_VERSION}-amd64_virtualbox.box: debian-${DEBIAN_VERSION}-amd64-netinst.timestamp http/debian-preseed.cfg scripts/*.sh
	packer build debian-${DEBIAN_VERSION}-amd64-netinst.json


# Force validation of input to Packer.
%.timestamp: %.json
	packer validate $< && touch $@
