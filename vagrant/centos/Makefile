#-------------------------------------------------------------------------------
# centos: Makefile
#
# Use this make file to construct the CentOS Vagrant boxes.
#-------------------------------------------------------------------------------
# Copyright (C) 2016 Brian Minard
#-------------------------------------------------------------------------------
.PHONY: all
all: check add-boxes


.PHONY: check
check:
	PACKER_VARS=centos-7.0-1406.json ${MAKE} -f Makefile.centos check
	PACKER_VARS=centos-7.2-1511.json ${MAKE} -f Makefile.centos check


# Remove all files (including Packer caches).
.PHONY: realclean
realclean: mostlyclean
	PACKER_VARS=centos-7.0-1406.json ${MAKE} -f Makefile.centos realclean
	PACKER_VARS=centos-7.2-1511.json ${MAKE} -f Makefile.centos realclean


# Remove files that take a long time to create (including Vagrant boxes,
# Vagrant box prerequisites and user credentials).
.PHONY: clean
clean: mostlyclean
	PACKER_VARS=centos-7.0-1406.json ${MAKE} -f Makefile.centos clean
	PACKER_VARS=centos-7.2-1511.json ${MAKE} -f Makefile.centos clean


# Remove files that are created quickly.
.PHONY: mostlyclean
mostlyclean:
	PACKER_VARS=centos-7.0-1406.json ${MAKE} -f Makefile.centos mostlyclean
	PACKER_VARS=centos-7.2-1511.json ${MAKE} -f Makefile.centos mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	PACKER_VARS=centos-7.0-1406.json ${MAKE} -f Makefile.centos add-boxes
	PACKER_VARS=centos-7.2-1511.json ${MAKE} -f Makefile.centos add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes: check
	PACKER_VARS=centos-7.0-1406.json ${MAKE} -f Makefile.centos create-boxes
	PACKER_VARS=centos-7.2-1511.json ${MAKE} -f Makefile.centos create-boxes
