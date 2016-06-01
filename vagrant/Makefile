#-------------------------------------------------------------------------------
# vagrant: Makefile
#
# Use this make file to construct all Vagrant boxes.
#-------------------------------------------------------------------------------
# The MIT License (MIT)
# Copyright (c) 2016 Brian Minard
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
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
