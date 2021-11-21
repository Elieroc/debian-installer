#! /bin/bash

# Automation of debian installation
# RUN AS ROOT !!
# Require an internet connexion
# Run it on an Ubuntu live or Debian Live with parted

# Variables
disk="/dev/vda"
debian_version="bullseye"
locale="fr_FR.UTF-8 UTF-8"
root_password="12345678"
username="elieroc"
user_password="azerty"
hostname="deb-strap"
ip="192.168.122.73"

function partitioning (){
parted $disk << EOP
mklabel gpt
mkpart "EFI" fat32 1 512
set 1 esp on
mkpart "SWAP" linux-swap 512 1512
mkpart primary ext4 1512 100%
EOP
}

function formating(){
mkfs.vfat -F32 ${disk}1
mkswap ${disk}2
mkfs.ext4 ${disk}3
}

function install(){
    # Mounting
mkdir -p /mnt/boot/efi
mount ${disk}1 /mnt/boot/efi
mount ${disk}2 /mnt
    # Install debootstrap and refresh repos
apt install debootstrap -y
apt update
    # Run debootstrap
debootstrap ${debian_version} /mnt
    # Preparing environment
cp source.list /mnt/etc/apt/
echo "nameserver 1.1.1.1" > /mnt/etc/resolv.conf
cp interfaces /mnt/etc/network/
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc
    # Chroot
chroot /mnt /bin/bash << CHROOT
    # Refresh repos
apt update
    # Time and Language configuration
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
echo ${locale} >> /etc/locale.gen
locale-gen
echo LANG="fr_FR.UTF-8" > /etc/locale.conf
export LANG=fr_FR.UTF-8
    # Users configuration
passwd << ROOTPASSWD
${root_password}
ROOTPASSWD
useradd -m ${username} -s /bin/bash
passwd << USERPASSWD
${user_password}
USERPASSWD
    # Installation of kernel
apt install linux-image-amd64 -y
    # Installation of other packages
apt install sudo nano build-essential
    # FSTAB configuration
apt install arch-install-scripts
gensftab -U / > /etc/fstab
    # Hostname configuration
echo ${hostname} > /etc/hostname
    # Hosts configuration
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "192.168.122.73 ${hostname}" >> /etc/hosts
    # Sudoers configuration
echo "${username} ALL=(ALL) ALL" >> /etc/sudoers
    # Grub configuration
apt install grub-efi-amd64 -y
grub-install ${disk}
update-grub
CHROOT
}

partitioning
formating
install
echo "Good !"