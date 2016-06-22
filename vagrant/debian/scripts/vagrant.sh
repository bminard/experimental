#!/bin/bash

### WARNING: DO NOT FORGET TO REMOVE IT IF ACCESSIBLE FROM OUTSIDE !!!

function add_vagrant_key {
    homedir=$(su - $1 -c 'echo $HOME')
    mkdir -pm u+rwx,og-rwx $homedir/.ssh
    mv /tmp/authorized_keys2 $homedir/.ssh # /tmp/authorized_keys2 is populated by the Packer template.
    chown -Rf $1. $homedir/.ssh
    chmod u+rw-x,og-rwx $homedir/.ssh/authorized_keys2
}

if [ $(grep -c vagrant /etc/passwd) == 0 ] ; then
    useradd vagrant -m
fi

# Add public key to vagrant user
add_vagrant_key vagrant
