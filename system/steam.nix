{ pkgs, ... }:
{
  programs.java.enable = true;
  programs.steam = {
    enable = true;
    package = pkgs.steam.override { withJava = true; };
  };
}
