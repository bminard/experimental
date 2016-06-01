Experiments with Vagrant and Packer
===================================

This repo contains updates to `Pierre Mavro`_'s work on `packer-debian`_
and to `Gavin Burris`_' work on CentOS 7.

The objective of these changes was to enhance my understaind of Packer and
Vagrant and their use in supporting virtual machine deployment.

This repo introduces the following changes to Pierre's and Gavin's work.

   - Make files to generate a Debian Virtual Box file.
     Pierre's work supports both Jessie and Wheezy.
   - Make files to generate a CentOS Virtual Box file.
     Gavin's work supports CentOS-7.0-1406.
   - Support for vagrant-metadata, a metadata.json generator.

Thanks to Pierre for providing making packer-debian public.
It provided an excellent start to my investigation.

Thanks to Gavin Burris for publishing information on using Vagrant and Packer on CentOS.
Gavin's work is Copyright (c) 2016 The Wharton School, The University of Pennsylvania.

.. _Gavin Burris: https://research-it.wharton.upenn.edu/news/minimal-linux-with-packer-and-vagrant/
.. _Pierre Mavro: https://github.com/deimosfr
.. _packer-debian: https://github.com/deimosfr/packer-debian
