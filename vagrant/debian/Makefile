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
	PACKER_VARS=debian-wheezy.json ${MAKE} -f Makefile.debian check


# Remove files that take a long time to create.
.PHONY: clean
clean: mostlyclean
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian clean
	PACKER_VARS=debian-wheezy.json ${MAKE} -f Makefile.debian clean
	-rm -fr packer_cache


# Remove files that are recreated quickly.
.PHONY: mostlyclean
mostlyclean:
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian mostlyclean
	PACKER_VARS=debian-wheezy.json ${MAKE} -f Makefile.debian mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian add-boxes
	PACKER_VARS=debian-wheezy.json ${MAKE} -f Makefile.debian add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes: check
	PACKER_VARS=debian-jessie.json ${MAKE} -f Makefile.debian create-boxes
	PACKER_VARS=debian-wheezy.json ${MAKE} -f Makefile.debian create-boxes
