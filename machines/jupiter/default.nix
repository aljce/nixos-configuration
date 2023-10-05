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

  # boot.initrd.kernelModules = [ "nvidia" ];
  # boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  hardware.enableRedistributableFirmware = true;
  hardware.nvidia.modesetting.enable = lib.mkDefault true;
  hardware.nvidia.powerManagement.enable = lib.mkDefault true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.prime.intelBusId = "PCI@00:02:0"; # "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = "PCI@01:00:0"; # "PCI:1:0:0";
  # hardware.opengl.driSupport = true;
  # hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.nvidiaPersistenced = true;
  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  # services.xserver.videoDrivers = [ "intel" ];

  time.hardwareClockInLocalTime = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "22.11";
}
