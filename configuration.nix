{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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
  };

  programs.bash = {
    enableCompletion = true;
  };

  networking.hostName = "braavos";
  networking.networkmanager.enable = true;

  i18n = {
    consoleFont = "sun12x22";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    tmux
    tree
    vim
    emacs
    w3m
    which
    openssl
    ncmpcpp

    # Haskell
    stack

    # Rust
    rustc
    cargo
  ];

  services = {
    mopidy = {
      enable = true;
      extensionPackages = [ pkgs.mopidy-spotify ];
      configuration = builtins.readFile "/etc/nixos/mopidy/mopidy.conf";
    };
  };

  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "password";
  };

  system.stateVersion = "16.09";

}
