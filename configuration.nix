{ config, pkgs, ... }:
let graphical = true;
in
{
  imports =
    [
      ./hardware-configuration.nix
    ] ++
    (if graphical then [./xserver.nix] else []);

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

  programs = {
    bash.enableCompletion = true;
    light.enable = true;
  };

  networking = {
    hostName = "braavos";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Basic Command line interfaces
    which
    wget
    git
    gitAndTools.hub
    tmux
    tree
    vim
    emacs
    w3m
    rtorrent
    parted
    taskwarrior
    ag

    # Encryption
    openssl
    gnupg
    pass

    # Scripting
    python

    # Fun
    ncmpcpp
    cmatrix

    # Emacs
    html2text
    offlineimap
    mu
    ledger
    hunspell
    # (hunspellWithDicts [hunspellDicts.en-us])

    # Haskell
    stack
    cabal2nix

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

  i18n.consoleFont = "sun12x22";

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
