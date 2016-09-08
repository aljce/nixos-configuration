{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    # X11
    haskellPackages.xmobar
    firefox
    xclip
    screenfetch
    dmenu
    zathura
  ];
  nixpkgs.config.firefox.enableAdobeFlash = true;

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
        default = "xmonad";
      };
    };
  };
}
