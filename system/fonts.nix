{ pkgs, ... }:
{ i18n.defaultLocale = "en_US.UTF-8";
  console = with pkgs; {
    font = "${terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [ terminus_font ]; 
    keyMap = "dvorak-programmer";
  };
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
  ];
}
