#-------------------------------------------------------------------------------
# fedora: Makefile
#
# Use this make file to construct the Fedora Vagrant boxes.
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
.PHONY: all
all: check add-boxes


.PHONY: check
check:
	PACKER_VARS=fedora-13.json ${MAKE} -f Makefile.fedora check


# Remove all files (including Packer caches).
.PHONY: realclean
realclean: clean
	PACKER_VARS=fedora-13.json ${MAKE} -f Makefile.fedora realclean


# Remove files that take a long time to create (including Vagrant boxes,
# Vagrant box prerequisites and user credentials).
.PHONY: clean
clean: mostlyclean
	PACKER_VARS=fedora-13.json ${MAKE} -f Makefile.fedora clean
	-rm -fr packer_cache


# Remove files that are created quickly.
.PHONY: mostlyclean
mostlyclean:
	PACKER_VARS=fedora-13.json ${MAKE} -f Makefile.fedora mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	PACKER_VARS=fedora-13.json ${MAKE} -f Makefile.fedora add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes: check
	PACKER_VARS=fedora-13.json ${MAKE} -f Makefile.fedora create-boxes
