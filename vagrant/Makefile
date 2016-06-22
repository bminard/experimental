#-------------------------------------------------------------------------------
# vagrant: Makefile
#
# Use this make file to construct all Vagrant boxes.
#-------------------------------------------------------------------------------
# Copyright (C) 2016  Brian Minard
#-------------------------------------------------------------------------------
.PHONY: all
all: check add-boxes


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	${MAKE} -C centos add-boxes
	${MAKE} -C debian add-boxes
	${MAKE} -C fedora add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes:
	${MAKE} -C centos create-boxes
	${MAKE} -C debian create-boxes
	${MAKE} -C fedora create-boxes


.PHONY: check
check:
	${MAKE} -C centos check
	${MAKE} -C debian check
	${MAKE} -C fedora check


# Remove files that take a long time to create.
.PHONY: clean
clean: mostlyclean
	${MAKE} -C centos clean
	${MAKE} -C debian clean
	${MAKE} -C fedora clean


# Remove files that are recreated quickly.
.PHONY: mostlyclean
mostlyclean:
	${MAKE} -C centos mostlyclean
	${MAKE} -C debian mostlyclean
	${MAKE} -C fedora mostlyclean


.PHONY: install
install: python-virtual-environment


.PHONY: python-virtual-environment
python-virtual-environment: virtualenv.sh
	sh virtualenv.sh vagrant-metadata
