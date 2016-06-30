Packer Debian
=============

Packer configuration to generate Debian VirtualBox image/Vagrant boxes.

Usage
-----

To generate a VirtualBox image, edit debian-<version>.json (replace <version>
by the Debian version like wheezy) and adapt the following fields.
  - os_version
  - installer_conf
  - iso_checksum
  - iso_url

```
    {
      "os_version": "7.11.0",
      "installer_conf": "preseed_wheezy.cfg",
      "iso_checksum": "62876fb786f203bc732ec1bd2ca4c8faea19d0a97c5936d69f3406ef92ff49bd",
      "iso_url": "http://cdimage.debian.org/mirror/cdimage/archive/latest-oldstable/amd64/iso-cd/debian-7.11.0-amd64-netinst.iso"
    }

```
Once done, create your box file:
```
packer build -var 'ssh_private_key=credentials/vagrant_ssh_key' -var-file=debian-jessie.json debian.json
```
So for example:
```
packer build debian-jessie.json
```

Alternatively,
```
PACKER_TEMPLATE=debian-jessie.json make -f Makefile.debian add-boxes
```

That's it :-)

To manage multiple versions of Debian update the ``Makefile`` provided in this directory.
To update the ``Makefile``, add the name of the Packer template (e.g., "debian-version.json") to each makefile target.
