#!/bin/sh
opkg update
opkg install swap-utils
df -h
echo "Creating swap.page"
dd if=/dev/zero of=/mnt/sda1/swap.page bs=1M count=2048
mkswap /mnt/sda1/swap.page
swapon /mnt/sda1/swap.page
block detect > /etc/config/fstab
uci set fstab.@mount[0].enabled='1'
uci commit fstab
echo "SWAP_FILE=/mnt/sda1/swap.page"
echo "if [ -e "'$SWAP_FILE'" ]; then"
echo "	swapon $SWAP_FILE"
echo "fi"
vi /etc/rc.local
free
echo "Rebooting; Please don't panic"
reboot