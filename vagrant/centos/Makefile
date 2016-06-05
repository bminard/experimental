#-------------------------------------------------------------------------------
# centos: Makefile
#
# Use this make file to construct the CentOS Vagrant boxes.
#-------------------------------------------------------------------------------
.PHONY: all
all: check add-boxes


.PHONY: check
check:
	PACKER_TEMPLATE=centos-7.0-1406.json ${MAKE} -f Makefile.centos check


# Remove files that take a long time to create.
.PHONY: clean
clean: mostlyclean
	PACKER_TEMPLATE=centos-7.0-1406.json ${MAKE} -f Makefile.centos clean
	-rm -fr packer_cache


# Remove files that are recreated quickly.
.PHONY: mostlyclean
mostlyclean:
	PACKER_TEMPLATE=centos-7.0-1406.json ${MAKE} -f Makefile.centos mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	PACKER_TEMPLATE=centos-7.0-1406.json ${MAKE} -f Makefile.centos add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes: check
	PACKER_TEMPLATE=centos-7.0-1406.json ${MAKE} -f Makefile.centos create-boxes
