{ config, pkgs, ... }:
{ imports = [ 
    ../hardware-configuration.nix
    ../users.nix
    ../programs.nix
    ../fonts.nix
    ../dotfiles.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.luks.devices = [
    { name = "root";
      device = "/dev/nvme0n1p3";
    }
  ];

  networking.wireless.enable = true;
  networking.hostId = "39bae8d0";

  time.timeZone = "America/New_York";

  system.stateVersion = "18.03";
}
