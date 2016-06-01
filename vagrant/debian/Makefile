#-------------------------------------------------------------------------------
# debian: Makefile
#
# Use this make file to construct the Debian Vagrant boxes.
#-------------------------------------------------------------------------------
.PHONY: check
check:
	VERSION=7.9.0 CODE_NAME=jessie ${MAKE} -f Makefile.debian check
	VERSION=8.4.0 CODE_NAME=wheezy ${MAKE} -f Makefile.debian check


# Remove files that take a long time to create.
.PHONY: clean
clean: mostlyclean
	VERSION=7.9.0 CODE_NAME=jessie ${MAKE} -f Makefile.debian clean
	VERSION=8.4.0 CODE_NAME=wheezy ${MAKE} -f Makefile.debian clean
	-rm -fr packer_cache


# Remove files that are recreated quickly.
.PHONY: mostlyclean
mostlyclean:
	VERSION=7.9.0 CODE_NAME=jessie ${MAKE} -f Makefile.debian mostlyclean
	VERSION=8.4.0 CODE_NAME=wheezy ${MAKE} -f Makefile.debian mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	VERSION=7.9.0 CODE_NAME=jessie ${MAKE} -f Makefile.debian add-boxes
	VERSION=8.4.0 CODE_NAME=wheezy ${MAKE} -f Makefile.debian add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes:
	VERSION=7.9.0 CODE_NAME=jessie ${MAKE} -f Makefile.debian create-boxes
	VERSION=8.4.0 CODE_NAME=wheezy ${MAKE} -f Makefile.debian create-boxes
