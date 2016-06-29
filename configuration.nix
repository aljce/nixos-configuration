# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.luks.devices = [
	  {
		  name = "root";
		  device = "/dev/sda2";
		  preLVM = true;
	  }
  ];

  hardware = {
 	  cpu.intel.updateMicrocode = true;
	  bumblebee.enable = true;
	  # For a later date
	  # pulseaudio = {
    # 	enable = true;
	  # 	configFile = "path";
	  #   support32Bit = true;
	  # };
  };

  networking = {
    hostName = "braavos";
    networkmanager.enable = true;
    nat = {
     enable = true;
     internalInterfaces = ["ve-+"];
     externalInterface = "enp9s0";
    };
  };

  programs.bash = {
	  enableCompletion = true;
	  # initeractiveShellInit = "";
	  # promptInit = "source /etc/nixos/dotfiles/liquidprompt/liquidprompt";
	  # shellAliases = { };
  };

  # programs.light.enable = true;

  security.sudo.extraConfig = "";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "sun12x22";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
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
      configuration = "";
		  extraConfigFiles = 
			[ "./dotfiles/mopidy/mopidy.conf" ];
	  };
	  nixosManual.showManual = true;
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
	  home = "/home/kyle";
	  initialPassword = "password";
 	  description  = "Kyle McKean's unprivileged user";
	  extraGroups  =  [
		  "wheel"
	  ];
  };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";
}
