{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "saturn";
    hostId = "39bae8d0";
  };

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/nvme0n1";
    };
    supportedFilesystems = [ "zfs" ];
    initrd = {
      luks.devices.crypt-root = {
        device = "/dev/nvme0n1p2";
      };
      kernelModules = [ "i915" ];
    };
  };

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "22.05";
}
