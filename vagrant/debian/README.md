Packer Debian
=============

Packer configuration to generate Debian VirtualBox image/Vagrant boxes.

Usage
-----

To generate a VirtualBox image, edit debian-<version>.json (replace <version> by the Debian version like wheezy) and adapt the `os_version` field:
```
    "variables": {
        "os_version": "7.7.0",
    },

```
Once done, create your box file:
```
packer build debian-<version>
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
