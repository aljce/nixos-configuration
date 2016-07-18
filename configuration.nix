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
    git-hub
    tmux
    tree
    vim
    emacs
    w3m
    rtorrent
    parted
    taskwarrior

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

    # Rust
    rustc
    cargo

    # X11
    haskellPackages.xmobar
    rxvt_unicode
    firefox
    xclip
    screenfetch
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
    xserver = {
      enable = true;
      layout = "us";
      desktopManager = {
        default = "none";
        xterm.enable = false;
      };
      displayManager.lightdm = {
        enable = true;
        background = "/usr/share/wallpaper";
      };
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
        default = "xmonad";
      };
      synaptics = {
        enable = true;
        twoFingerScroll = true;
      };
    };
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
