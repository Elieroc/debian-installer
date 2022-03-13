#!/bin/bash

### Debian ISO Creator ###<

# Dev     : Elieroc
# Version : Beta

# Requirements : sudo, wget, isomkfs

DEBIAN_DOWNLOAD_LINK="https://cdimage.debian.org/cdimage/archive/10.11.0/amd64/iso-cd/debian-10.11.0-amd64-netinst.iso"
DEBIAN_TEMPLATE="base"
DEBIAN_ORI_ISO_DIR="debian-ori"
DEBIAN_ORI_ISO_NAME=$( cd $DEBIAN_ORI_ISO_DIR&&ls debian-*&&cd .. )
DEBIAN_MODDED_ISO_NAME="debian-${DEBIAN_TEMPLATE}.iso"
DEBIAN_MODDED_DIR="output"
WORKSPACE="tmp"
MOUNT_DIR="/mnt/iso"
CURRENT_USER=$USER

if [ -z $DEBIAN_ORI_ISO_NAME ]
then
    DEBIAN_ORI_ISO_NAME="debian-original.iso"
    wget -O ${DEBIAN_ORI_ISO_DIR}/${DEBIAN_ORI_ISO_NAME} $DEBIAN_DOWNLOAD_LINK
fi

mkdir $WORKSPACE
mkdir -p $MOUNT_DIR
sudo mount -o loop ${DEBIAN_ORI_ISO_DIR}/${DEBIAN_ORI_ISO_NAME} $MOUNT_DIR | echo ""
sudo cp -r ${MOUNT_DIR}/* $WORKSPACE
sudo umount $MOUNT_DIR
sudo cp resources/* ${WORKSPACE}/isolinux/
mkdir ${WORKSPACE}/ps
sudo cp ${DEBIAN_TEMPLATE}/${DEBIAN_TEMPLATE}.cfg ${WORKSPACE}/ps/
cd $WORKSPACE
sudo mkisofs -o ../${DEBIAN_MODDED_DIR}/${DEBIAN_MODDED_ISO_NAME} -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -r . $PWD && cd ..
sudo chown ${CURRENT_USER}:${CURRENT_USER} ${DEBIAN_MODDED_DIR}/${DEBIAN_MODDED_ISO_NAME}
sudo rm -rf tmp/
