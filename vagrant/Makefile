.PHONY: all
all: vagrant


.PHONY: vagrant
vagrant: debian


# Name the packer JSON file after the ISO image it consumes.
DEBIAN_VERSION?=8.4.0
debian: debian-${DEBIAN_VERSION}-amd64_virtualbox.box
debian-${DEBIAN_VERSION}-amd64_virtualbox.box: debian-${DEBIAN_VERSION}-amd64-netinst.timestamp http/debian-preseed.cfg scripts/*.sh
	packer build debian-${DEBIAN_VERSION}-amd64-netinst.json


# Force validation of input to Packer.
%.timestamp: %.json
	packer validate $< && touch $@
