{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    # X11
    st
    haskellPackages.xmobar
    feh
    firefox
    google-chrome
    xclip
    screenfetch
    shutter
    dmenu
    zathura
    evince
    (
    neovim.override {
      configure = {
        customRC = ''
	        source ~/.SpaceVim/vimrc
	      '';
        vam = {
          knownPlugins = vimPlugins;
          pluginDictionaries = [
            { name = "vimproc"; }
          ];
        };
      };
    }
    )
    xorg.mkfontdir
    xorg.mkfontscale
    slack
    vlc
    arandr
    wireshark
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "dvp";
      xkbOptions = "caps:swapescape";
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
        # default = "xmonad";
      };
      libinput.enable = true;
    };
  };

  programs.light.enable = true;
}
