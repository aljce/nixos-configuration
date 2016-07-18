{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # X11
    haskellPackages.xmobar
    rxvt_unicode
    firefox
    xclip
    screenfetch
  ];
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
      # synaptics = {
      #   enable = true;
      #   twoFingerScroll = true;
      # };
    };
  };
}
