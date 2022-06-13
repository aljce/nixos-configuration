{ pkgs, ... }:
{ i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak-programmer";
  };
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
  ];
}
