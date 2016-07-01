#-------------------------------------------------------------------------------
# debian: Makefile
#
# Use this make file to construct the Debian Vagrant boxes.
#-------------------------------------------------------------------------------
.PHONY: all
all: check add-boxes


.PHONY: check
check:
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian check


# Remove all files (including Packer caches).
.PHONY: realclean
realclean: mostlyclean
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian realclean


# Remove files that take a long time to create (including Vagrant boxes,
# Vagrant box prerequisites and user credentials).
.PHONY: clean
clean: mostlyclean
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian clean



# Remove files that are created quickly.
mostlyclean:
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes: check
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian create-boxes
