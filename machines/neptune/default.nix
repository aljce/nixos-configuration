{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "neptune";
    hostId = "f182f5a7";
  };

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        configurationLimit = 8; # windows boot partition is small
        devices = [ "nodev" ];
        efiSupport = true;
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root F6F3-4088
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
      timeout = null; # wait on boot screen indefinitely
    };
    supportedFilesystems = [ "zfs" ];
    initrd.luks.devices.crypt-root = {
      device = "/dev/nvme0n1p1";
    };
  };

  hardware.enableRedistributableFirmware = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  time.hardwareClockInLocalTime = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "22.05";
}
