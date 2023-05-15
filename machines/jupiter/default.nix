{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "jupiter";
    hostId = "c176a4be";
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
            search --fs-uuid --set=root C431-7120
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
      timeout = null; # wait on boot screen indefinitely
    };
    supportedFilesystems = [ "zfs" ];
    initrd.luks.devices.crypt-root = {
      device = "/dev/nvme0n1p4";
    };
  };

  hardware.enableRedistributableFirmware = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.bumblebee.enable = true;
  # hardware.nvidia.prime.offload.enable = true;
  # hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";
  # hardware.nvidia.prime.intelBusId = "PCI:0:2:0";
  services.xserver.videoDrivers = [ "nvidia" ];

  time.hardwareClockInLocalTime = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "22.11";
}
