{ config, pkgs, ... }:

{
  imports =
    [ ../hardware-configuration.nix
      ../users.nix
      ../programs.nix
      ../networking.nix
      ../nix.nix
      ../fonts.nix
      ../xserver.nix
      ../dotfiles.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    { name = "root";
      device = "/dev/nvme1n1p2";
    }
  ];
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostId = "f182f5a7";

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "19.09";
}

