{ config, pkgs, ... }:
{ imports =
    [ ../system/users.nix
      ../system/programs.nix
      ../system/audio.nix
      ../system/networking.nix
      ../system/nix.nix
      ../system/fonts.nix
      ../system/crypto.nix
      ../system/home-manager.nix
      ../system/mercury.nix
      ../home/modules
      ../home/alice
    ];

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
    };
    supportedFilesystems = [ "zfs" ];
    initrd.luks.devices.crypt-root = {
      device = "/dev/nvme0n1p1";
    };
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackges;
  };

  hardware.enableRedistributableFirmware = true;
  services.xserver.videoDrivers = [ "radeon" ];

  hardware.bluetooth.enable = true;

  networking.hostId = "f182f5a7";

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "20.09";
}
