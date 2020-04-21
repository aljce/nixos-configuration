{ config, pkgs, ... }:
{ imports = [
    ../hardware-configuration.nix
    ../users.nix
    ../programs.nix
    ../networking.nix
    ../nix.nix
    ../fonts.nix
    ../xserver.nix
    ../audio.nix
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

  networking.hostId = "39bae8d0";

  # networking.usePredictableInterfaceNames = false;
  networking.networkmanager.wifi.macAddress = "permanant";

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "19.03";

  hardware.u2f.enable = true;
  hardware.bluetooth.enable = true;

  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_10;
    };
    elasticsearch = {
      enable = true;
    };
  };
}
