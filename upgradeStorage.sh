#!/bin/sh
opkg update
opkg install kmod-usb-storage-extras e2fsprogs kmod-fs-ext4 block-mount

umount /tmp/mounts/USB-A1 # the USB drive shows up as USB-A1 in /tmp/mounts
mkfs.ext4 /dev/sda1
mkdir /mnt/sda1
mount /dev/sda1 /mnt/sda1

mount /dev/sda1 /mnt/ ; tar -C /overlay -cvf - . | tar -C /mnt/ -xf - ; umount /mnt/

#opkg install block-mount
block detect > /etc/config/fstab
echo "option  target  '/mnt/<device name>' -> option target '/overlay'"
echo "option  enabled '0' -> option  enabled '1'"
vi /etc/config/fstab

df -h
echo "Rebooting; Please don't panic"
reboot