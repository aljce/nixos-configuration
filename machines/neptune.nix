{ config, pkgs, ...}:
{
  imports =
    [
      ../hardware-configuration.nix
      ../users.nix
      ../sshd.nix
      ../programs.nix
    ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    initrd.luks.devices = [{
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
    }];
  };

  hardware.cpu.intel.updateMicrocode = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Experimental Packeges
  environment.systemPackages = with pkgs; [
  ];

  services = {
  };

  system.stateVersion = "16.09";
}
