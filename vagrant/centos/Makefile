#-------------------------------------------------------------------------------
# centos: Makefile
#
# Use this make file to construct the CentOS Vagrant boxes.
#-------------------------------------------------------------------------------
.PHONY: check
check:


# Remove files that take a long time to create.
.PHONY: clean
clean: mostlyclean
	-rm -fr packer_cache


# Remove files that are recreated quickly.
.PHONY: mostlyclean
mostlyclean:


# Use Vagrant to register a box descriptor.
.PHONY: add-boxes
add-boxes: create-boxes


# Use Packer to create Vagrant boxes for each builder template.
.PHONY: create-boxes
create-boxes:
