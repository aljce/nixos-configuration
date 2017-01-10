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
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices = [{
      name = "root";
      device = "/dev/sda2";
      preLVM = true;
      allowDiscards = true;
    }];
    extraModprobeConfig = ''
      options snd_mia index=0
      options snd_hda_intel index=1
    '';
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
  };

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
    mopidy = {
      enable = true;
      extensionPackages = [ pkgs.mopidy-spotify ];
      configuration = builtins.readFile "/etc/nixos/mopidy/mopidy.conf";
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
    };
  };

  system.stateVersion = "16.09";
}
