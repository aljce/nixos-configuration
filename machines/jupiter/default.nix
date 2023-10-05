{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "jupiter";
    hostId = "c176a4be";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_6_1;
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

  hardware = {
    enableRedistributableFirmware = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;
      nvidiaPersistenced = true;
      prime = {
        sync.enable = true;
        intelBusId = "PCI@00:02:0";
        nvidiaBusId = "PCI@01:00:0";
      };
    };
    bluetooth.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" "intel" ];

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "America/Los_Angeles";
  };

  system.stateVersion = "22.11";
}
