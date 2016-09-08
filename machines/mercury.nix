{ pkgs, ... }:
{ imports = [
    ../hardware-configuration.nix
    ../users.nix
    ../xserver.nix
    ../programs.nix
    ../fonts.nix
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

  hardware.cpu.intel.updateMicrocode = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Experimental Packeges
  environment.systemPackages = with pkgs; [
    darcs
    calc

    rustracer
    python3

    eclipses.eclipse-sdk-46
    sbt
  ];

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
