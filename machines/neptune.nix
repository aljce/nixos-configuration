{ pkgs, ... }:
{ imports = [
    ../hardware-configuration.nix
    ../users.nix
    ../services/sshd.nix
    ../programs.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    initrd = {
      luks.devices = [{
        name = "root";
        device = "/dev/sda3";
        preLVM = true;
      }];
      network.ssh = {
        enable = true;
        authorizedKeys = [ builtins.readFile ../public-keys/kyle/mercucy.pub ];
      };
    };
  };

  hardware.cpu.intel.updateMicrocode = true;

  networking.firewall = {
    allowedTCPPorts = [ 22 80 443 ];
  };

  time.timeZone = "America/New_York";

  # Experimental Packeges
  environment.systemPackages = with pkgs; [
  ];

  services = {
  };

  system.stateVersion = "16.09";
}
