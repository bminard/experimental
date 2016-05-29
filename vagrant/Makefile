DEBIAN_VERSION?=8.4.0


.PHONY: all
all: check vagrant


.PHONY: check
check: debian-${DEBIAN_VERSION}-amd64-netinst.timestamp


.PHONY: vagrant
vagrant: debian


# Name the packer JSON file after the ISO image it consumes.
debian: debian-${DEBIAN_VERSION}-amd64_virtualbox.box
debian-${DEBIAN_VERSION}-amd64_virtualbox.box: debian-${DEBIAN_VERSION}-amd64-netinst.timestamp http/debian-preseed.cfg scripts/*.sh
	packer build debian-${DEBIAN_VERSION}-amd64-netinst.json


# Force validation of input to Packer.
%.timestamp: %.json
	packer validate $< && touch $@
