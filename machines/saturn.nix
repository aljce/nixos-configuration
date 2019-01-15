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
    /home/amckean/repos/nixos-configs/netboot_server.nix
    /home/amckean/repos/nixos-configs/qemu.nix
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

  networking.usePredictableInterfaceNames = false;

  # UNGODLY HACKS
  netboot_server.network = {
    lan = "eth0";
    wan = "wlan0";
  };

  qemu-user.aarch64 = true;

  time.timeZone = "America/New_York";

  system.stateVersion = "18.03";
}
