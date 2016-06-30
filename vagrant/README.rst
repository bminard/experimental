Experiments with Vagrant and Packer
===================================

This repo contains updates to `Pierre Mavro`_'s work on `packer-debian`_
and to `Gavin Burris`_' work on CentOS 7.

The objective of these changes was to enhance my understaind of Packer and
Vagrant and their use in supporting virtual machine deployment.

Additional resources:
  - `Boxcutter`_
  - `Using Packer and Vagrant to Build Virtual Machines`_ by Florian Motlik

This repo introduces the following changes to Pierre's and Gavin's work.

   - Make files to generate a Debian Virtual Box file.
     Pierre's work supports both Jessie and Wheezy.
   - Make files to generate a CentOS Virtual Box file.
     Gavin's work supports CentOS-7.0-1406.

Thanks to Pierre for providing making packer-debian public.
It provided an excellent start to my investigation.

Thanks to Gavin Burris for publishing information on using Vagrant and Packer on CentOS.
Gavin's work is Copyright (c) 2016 The Wharton School, The University of Pennsylvania.

Thanks to Florian Motlik.
His example allowed me to understand Vagrant better.

This repo introduces support for Fedora.
No `Boxcutter`_ code is contained herein.
`Boxcutter`_ and `Boxcutter Fedora`_ did influence the my implementation.

Prerequisites
-------------

  - GNU Make 3.85
  - Packer 0.10.1
  - Vagrant 1.8.1
  - Python's passlib

Using Python's `virtualenv`_?
`make install` takes care of Python dependencies.
It will not install Python modules into anything other than a virtual environment,

Using
-----

First, update your environment.
Run `exportenv.sh` in the project's root directory::

        > source exportenv.sh `pwd`

Optionally, run::

        > make install

To build every Vagrant Box::

        > make all

To build every Vagrant Box for a specified distribution (e.g., Debian)::

        > cd debian; make all

.. _Boxcutter Fedora: https://github.com/boxcutter/fedora
.. _Boxcutter: https://github.com/boxcutter
.. _Gavin Burris: https://research-it.wharton.upenn.edu/news/minimal-linux-with-packer-and-vagrant/
.. _Pierre Mavro: https://github.com/deimosfr
.. _Using Packer and Vagrant to Build Virtual Machines: https://blog.codeship.com/packer-vagrant-tutorial/
.. _packer-debian: https://github.com/deimosfr/packer-debian
.. _virtualenv: https://virtualenv.pypa.io/en/stable/
