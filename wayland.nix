{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    alacritty
    firefox
  ];

  services = {
  };

  programs = {
    light.enable = true;
    sway = {
      enable = true;
      extraPackages = [
        pkgs.swaylock
      ]; 
    };   
  };
 
}
