{ config, pkgs, lib, ... }:
{ imports = [
    ../system/users.nix
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

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.luks.devices.crypt-root = {
    device = "/dev/nvme0n1p2";
  };

  boot.initrd.kernelModules = [ "i915" ];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];

  networking.hostId = "39bae8d0";

  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "20.09";
}
