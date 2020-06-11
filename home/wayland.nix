{ pkgs, lib, ... }:
let fonts = [ "source-code-pro 10" ];
    modifier = "Mod1";
in
{ programs.sway.enable = true; 
  home-manager.users.alice = {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        inherit fonts;
        gaps = {
          inner = 5;
          outer = 5;
        };
        input = {
          "*" = {
            xkb_layout = "us";
            xkb_variant = "dvp";
            xkb_options = "caps:swapescape";
          };
        };
        output = {
          "*" = {
            bg = "${../artwork/fractal.png} center";
          };
        };
        inherit modifier;
        keybindings = lib.mkOptionDefault {};
        menu = "";
        terminal = "alacritty";
      };
    };
    home.packages = with pkgs; [
      wl-clipboard
    ];
    xdg.configFile."environment.d/envvars.conf".text = ''
      MOZ_ENABLE_WAYLAND=1
    '';
    programs = {
      firefox = {
        enable = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          browserpass
          browserpass-otp
          ublock-origin
        ];
      };
      alacritty = {
        enable = true;
      };
      mako = {
        enable = true;
      };
    };
    services = {
      redshift = {
        enable = false;
        provider = "geoclue2";
      };
    };
  };
  services.geoclue2.enable = false;
}
