{ pkgs, ... }:
{ hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  # hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
}
