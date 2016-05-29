Experiments with Vagrant and Packer
===================================

This directory contains experimental changes `Pierre Mavro`_'s work on `packer-debian`_. These changes respect Pierre's :file:`LICENCE`.

I did not retain the original files. Yeah, I made a mess.

This repo introduces the following changes.
   - supports only Debian 8.4.0. Major change is the specification of the Grub2 MBR device in the preseed configuration file.
   - a Makefile to generate the Virtual Box file.

My objectives for this experiement aren't to create a Debian Virtual Box image. I'm trying to understand how Vagrant and Packer work together to determine if they are useful components for my own deployment of virtual machines.

Thank's to Pierre for providing making packer-debian public. It provided an excellent start for my own work.

.. _Pierre Mavro: https://github.com/deimosfr
.. _packer-debian: https://github.com/deimosfr/packer-debian
