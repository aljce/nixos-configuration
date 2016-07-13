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

  networking = {
    hostName = "braavos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    which
    wget
    git
    git-hub
    tmux
    tree
    vim
    emacs
    w3m
    openssl
    rtorrent
    parted

    # Fun
    ncmpcpp
    cmatrix

    # Development
    hunspell

    # Haskell
    stack

    # Rust
    rustc
    cargo
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      tewi-font
      inconsolata
      source-code-pro
    ];
  };

  services = {
    kmscon = {
      enable = true;
      extraConfig = ''
        font-name=SourceCodePro
        font-size=24
      '';
      hwRender = true;
    };
    mopidy = {
      enable = true;
      extensionPackages = [ pkgs.mopidy-spotify ];
      configuration = builtins.readFile "/etc/nixos/mopidy/mopidy.conf";
    };
  };

  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" "power" ];
    initialPassword = "password";
  };

  system.stateVersion = "16.09";

}
