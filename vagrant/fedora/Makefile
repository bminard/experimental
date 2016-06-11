#-------------------------------------------------------------------------------
# fedora: Makefile
#
# Use this make file to construct the Fedora Vagrant boxes.
#-------------------------------------------------------------------------------
.PHONY: all
all: check add-boxes


.PHONY: check
check:
	PACKER_TEMPLATE=fedora-13.json ${MAKE} -f Makefile.fedora check


# Remove files that take a long time to create.
.PHONY: clean
clean: mostlyclean
	PACKER_TEMPLATE=fedora-13.json ${MAKE} -f Makefile.fedora clean
	-rm -fr packer_cache


# Remove files that are recreated quickly.
.PHONY: mostlyclean
mostlyclean:
	PACKER_TEMPLATE=fedora-13.json ${MAKE} -f Makefile.fedora mostlyclean


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes
	PACKER_TEMPLATE=fedora-13.json ${MAKE} -f Makefile.fedora add-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes: check
	PACKER_TEMPLATE=fedora-13.json ${MAKE} -f Makefile.fedora create-boxes
