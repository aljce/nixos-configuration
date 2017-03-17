{ pkgs, ... }:
{ imports = [
    ../hardware-configuration.nix
    ../users.nix
    ../xserver.nix
    ../programs.nix
    ../fonts.nix
    ../layer3.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
    initrd.luks.devices = [{
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
      allowDiscards = true;
    }];
  };

  hardware.cpu.intel.updateMicrocode = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Experimental Packeges
  environment.systemPackages = with pkgs; [
    darcs
    calc
    # haskellPackages.Agda
    jdk
    travis
  ];

  nix = {
    trustedBinaryCaches = [ "https://nixcache.reflex-frp.org" ];
    binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
  };

  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
    };
  };

  system.stateVersion = "16.09";
}
