# NixOS Configuration Files
I keep two things in these files:
* System wide packages
* Hardware specific configuration files for a *lenovo y50-70* 

All other configuration files can be found in my [dotfiles repo](https://github.com/mckeankyle/dotfiles)
# Disk Partioning
/boot is unencrypted
All other partions are encrypted
```sh
NAME          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda             8:0    0 238.5G  0 disk
├─sda1          8:1    0   512M  0 part  /boot
└─sda2          8:2    0   238G  0 part
  └─root      254:0    0   238G  0 crypt 
    ├─vg-root 254:1    0    10G  0 lvm   /
    ├─vg-nix  254:2    0    30G  0 lvm   /nix
    ├─vg-var  254:3    0    10G  0 lvm   /var
    └─vg-home 254:4    0   188G  0 lvm   /home
```

# Install
*WARNING* The following steps create an entire operating system this goes without saying but backup your data on the device you choose.
```sh
# Boot into nixos iso image
# Configure networking
nix-env --install git vim
git clone https://github.com/mckeankylej/nixos-configuration.git
nixos-configuration/partition /dev/sdX
cp -r nixos-configuration/* /mnt/etc/nixos
# Make personal changes to /mnt/etc/nixos/configuration.nix and other modules
nixos-install
```
