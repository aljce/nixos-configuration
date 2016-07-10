# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/sda2";
        preLVM = true;
        allowDiscards = true;
      }
    ];
    extraModprobeConfig = ''
      options snd_mia index=0
      options snd_hda_intel index=1
    '';
  };

  hardware = {
 	  cpu.intel.updateMicrocode = true;
	  bumblebee.enable = true;
	  # For a later date
	  pulseaudio = {
    	enable = true;
	  	# configFile = /etc/nixos/dotfiles/pulse/default.pa;
	    # support32Bit = true;
      # package = pkgs.pulseaudioFull;
	  };
  };

  networking = {
    hostName = "braavos";
    networkmanager.enable = true;
  };

  programs.bash = {
	  enableCompletion = true;
	  # promptInit = "";
	  # shellAliases = { };
  };

  # programs.light.enable = true;

  security.sudo.extraConfig = "";

  i18n = {
    consoleFont = "sun12x22";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    # Console Programs
    wget
    vim
    emacs
    tmux
    tree
    git
    which
    w3m

    # Haskell
    stack
    cabal2nix
    cabal-install

    # Rust
    rustc
    cargo

    # X11
    haskellPackages.xmobar
    rxvt_unicode
    firefox
    xclip
    ncmpcpp
  ];

  nixpkgs.config = {
	  allowUnfree = true;
  };

  services = {
	  # openssh.enable = true;
	  mopidy = {
		  enable = true;
		  extensionPackages = [ pkgs.mopidy-spotify ];
      configuration = builtins.readFile "/etc/nixos/dotfiles/mopidy/mopidy.conf";
	  };
	  xserver = {
	  	enable = true;
		  desktopManager = {
			  default = "none";
			  xterm.enable = false;
		  };
		  displayManager.slim = {
			  enable = true;
			  defaultUser = "kyle";
			  # extraConfig = "";
			  # background = "path";
		  };
		  layout = "us";
		  synaptics = {
			  enable = true;
			  twoFingerScroll = true;
		  };
		  # videoDrivers = [ "nvidia" ];
		  windowManager.xmonad = {
			  enable = true;
			  enableContribAndExtras = true;
		  };
		  windowManager.default = "xmonad";
		  # xkbOptions = "";
		  # xkbVariant = "":
	  };

  };

  # virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.kyle = {
	  isNormalUser = true;
	  initialPassword = "password";
 	  description  = "Kyle McKean";
	  extraGroups  =  [
		  "wheel"
	  ];
  };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
