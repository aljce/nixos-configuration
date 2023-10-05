{ ... }:
{ services.xserver = {
    enable = true;
    autorun = false;
    desktopManager.plasma5 = {
      enable = true;
    };
    displayManager.lightdm.enable = true;
  };
}
