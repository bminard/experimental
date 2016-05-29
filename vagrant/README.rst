Experiments with Vagrant and Packer
===================================

This directory contains experimental changes `Pierre Mavro`_'s work on `packer-debian`_.
These changes respect Pierre's `LICENCE`.

I did not retain the original files. Yeah, I made a mess.

This repo introduces the following changes.

   - supports only Debian 8.4.0. Major change is the specification of the Grub2 MBR device in the preseed configuration file.
   - a Makefile to generate a Virtual Box file.
   - introduction of `scripts/puppet.sh` and modification to permit the use of `facter`_.
     Facter is in `packer-debian`_.
     It is abandoned or a WIP.

My objectives for this experiement aren't to create a Debian Virtual Box image.
I want to understand how Vagrant and Packer work together to determine if they are useful for my deployment of virtual machines.

Thank's to Pierre for providing making packer-debian public.
It provided an excellent start to my investigation.

.. _facter: https://docs.puppet.com/facter/latest/
.. _packer-debian: https://github.com/deimosfr/packer-debian
.. _Pierre Mavro: https://github.com/deimosfr
