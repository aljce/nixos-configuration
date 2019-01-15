{ pkgs, ... }:
{ i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvp";
    defaultLocale = "en_US.UTF-8";
  };

  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    fonts = [
      pkgs.source-code-pro
      pkgs.source-sans-pro
      pkgs.source-serif-pro
    ];
  };
}
