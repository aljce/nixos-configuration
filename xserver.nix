{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    # X11
    st
    alacritty
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
    xorg.mkfontdir
    xorg.mkfontscale
    slack
    vlc
    arandr
    wireshark
    mumble
    keybase
    keybase-gui
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "dvp";
      xkbOptions = "caps:swapescape";
      desktopManager = {
        plasma5 = {
          enable = true;
        };
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
      };
      # libinput.enable = true;
    };
    keybase.enable = true;
  };

  programs.light.enable = true;
}
