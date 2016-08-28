{ config, pkgs, ... }:
{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      tewi-font
      inconsolata
      source-code-pro
    ];
  };

  i18n.consoleFont = "sun12x22";
}
