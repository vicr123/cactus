systemctl enable NetworkManager
systemctl enable ModemManager
systemctl enable lightdm-plymouth
systemctl enable vboxservice
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-thedesk-greeter/' /etc/lightdm/lightdm.conf
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash"/' /etc/default/grub
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev plymouth autodetect modconf block filesystems keyboard fsck)/' /etc/default/grub
plymouth-set-default-theme -R bgrt-cactus
