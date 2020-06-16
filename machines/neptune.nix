{ config, pkgs, ... }:

{
  imports =
    [ ../system/users.nix
      ../system/programs.nix
      ../system/audio.nix
      ../system/networking.nix
      ../system/nix.nix
      ../system/fonts.nix
      ../system/home-manager.nix
      ../home/alice.nix
    ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices.crypt-root = {
    device = "/dev/nvme1n1p2";
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.bluetooth.enable = true;
  networking.hostId = "f182f5a7";

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "20.03";
}

