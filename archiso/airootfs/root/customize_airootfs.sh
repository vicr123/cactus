#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root
# unset the root password
passwd -d root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

systemctl enable plymouth-lightdm
systemctl enable NetworkManager
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev plymouth autodetect modconf block filesystems keyboard fsck)/' /etc/mkinitcpio.conf
plymouth-set-default-theme -R bgrt-cactus
