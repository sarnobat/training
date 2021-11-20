#!/bin/bash

if [ x"$SUDO_USER" = x ]; then
  echo Must use 'sudo' when running $0
  exit 1
fi

start_bridge () {
  if brctl show | grep ^"$1" > /dev/null ; then
    :
  else
    brctl addbr $1
  fi
}

start_machine () {
  if virsh list | grep ^"$1" > /dev/null ; then
    :
  else
    virsh start $1
  fi
}

# Lets kill any existing vm's before we go crazy
virsh destroy machine1 2> /dev/null > /dev/null
virsh destroy machine2 2> /dev/null > /dev/null

# Start network bridges.  Bridge br0 will hold both VM's eth0 interfaces.
# Likewise bridge br1 will hold both VM's eth1 interfaces.
start_bridge br0
start_bridge br1

##########################################################################
# Fresh qcow2 overlays for VM's disk images
olddir=$PWD
cd /home/student/virtual/images

rm machine1.img
rm machine2.img

qemu-img create -f qcow2 -b xubuntu_base.img machine1.img > /dev/null
qemu-img create -f qcow2 -b xubuntu_base.img machine2.img > /dev/null

chmod 666 machine1.img
chmod 666 machine2.img

cd $olddir
##########################################################################

start_machine machine1
start_machine machine2

virt-viewer --wait machine1 &
virt-viewer --wait machine2 &
