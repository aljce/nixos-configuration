# NixOS Configuration Files
Everything in this repo is fully declarative. You should be able to go from zero to OS in 15 minutes.
## Artwork
Contains various backgrounds I have collected over the years.
## Home
Dotfiles
## Machines
* Neptune (My main desktop)
* Saturn (A Purism Librem 15v3)
## System
Any configuration that will apply to all users on a machine usually hardware specific configuration.

# Install
*WARNING* The following steps create an entire operating system.
This goes without saying but backup your data on the device you choose.
```sh
cd install
nix-build iso.nix
sudo dd if=result/<iso> of=/dev/<usb>
# Boot into nixos iso image on /dev/<usb>
# Configure networking
partition --device /dev/<harddrive> --bios ([l]egacy|[u]efi)
# Make personal changes to /mnt/etc/nixos
echo "<hostname>" >> /mnt/etc/nixos/hostname # Must match the name of the file in /machines
nixos-install
```

