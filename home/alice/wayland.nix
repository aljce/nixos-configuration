{ pkgs, lib, ... }:
let swayfont = "source-code-pro 10";
    modifier = "Mod1";
    colors = import ./colors.nix { inherit lib; };
in
{ programs.sway.enable = true; 
  home-manager.users.alice = {
    imports = [ ../modules/waybar.nix ];
    wayland.windowManager.sway = {
      enable = true;
      config = {
        fonts = [ swayfont ];
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
            bg = "${../../artwork/fractal.png} center";
          };
        };
        inherit modifier;
        keybindings = {
          "${modifier}+d" = "exec rofi -show run | xargs swaymsg exec --";
          "${modifier}+c" = "kill";
          "${modifier}+Shift+c" = "exit";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+f" = "fullscreen";
          "${modifier}+Return" = "exec alacritty";
          "${modifier}+w" = "exec firefox";

          "${modifier}+Ampersand" = "workspace number 1";
          "${modifier}+BracketLeft" = "workspace number 2";
	  "${modifier}+BraceLeft" = "workspace number 3";
	  "${modifier}+BraceRight" = "workspace number 4";
	  "${modifier}+ParenLeft" = "workspace number 5";
	  "${modifier}+Equal" = "workspace number 6";
	  "${modifier}+Asterisk" = "workspace number 7";
	  "${modifier}+ParenRight" = "workspace number 8";
	  "${modifier}+Plus" = "workspace number 9";

	  "${modifier}+Shift+Ampersand" = "move container to workspace number 1";
	  "${modifier}+Shift+BracketLeft" = "move container to workspace number 2";
	  "${modifier}+Shift+BraceLeft" = "move container to workspace number 3";
	  "${modifier}+Shift+BraceRight" = "move container to workspace number 4";
	  "${modifier}+Shift+ParenLeft" = "move container to workspace number 5";
	  "${modifier}+Shift+Equal" = "move container to workspace number 6";
	  "${modifier}+Shift+Asterisk" = "move container to workspace number 7";
	  "${modifier}+Shift+ParenRight" = "move container to workspace number 8";
	  "${modifier}+Shift+Plus" = "move container to workspace number 9";
        };
        bars = [];
        startup = [{
          command = "exec systemctl --user restart waybar.service";
          always = true;
        }];
      };
    };
    services = {
      waybar = {
        enable = true;
        settings = builtins.toJSON [{
          layer = "bottom";
          position = "top";
          height = 40;
          modules-left = [ "sway/workspaces" ];
          modules-center = [ "sway/window" ];
          modules-right = [ "clock" ];
          "sway/window" = {
            format = "{}";
            max-length = 50;
          };
          clock = {
            format = "{:%H:%M}";
            tooltip-format = "{:Y-%m-%d | %H:%M}";
            format-alt = "{:Y-%m-%d}";
          };
        }];
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: 'Source Code Pro', 'Font Awesome 5';
            font-size: 20px;
            min-height: 0;
          }
          window#waybar {
            background: ${colors.hex colors.dark}; 
            border-bottom: 3px solid ${colors.hex colors.primary};
          }
          window#waybar.hidden {
            opacity: 0.0;
          }
        '';
      };
      redshift = {
        enable = true;
        package = pkgs.redshift-wlr;
        provider = "geoclue2";
      };
    };
    home.packages = with pkgs; [
      xwayland
      wl-clipboard
      rofi
      waybar
      signal-desktop
      spotify-tui
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
        settings = {
          env.TERM = "alacritty";
          draw_bold_text_with_bright_colors = true;
          font = {
            normal.family = "SourceCodePro";
            bold.family = "SourceCodePro";
            italic.family = "SourceCodePro";
            size = 18.0;
            offset = {
              x = 0;
              y = 0;
            };
            glyph_offset = {
              x = 0;
              y = 0;
            };
          };
          colors = {
            primary = {
              background = colors.hex colors.dark;
              foreground = colors.hex colors.light;
            };
            
          };
          background_opacity = 0.8;
        };
      };
      mako = {
        enable = true;
      };
      rofi.enable = true;
    };
  };
  services.geoclue2.enable = true;
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
  ];
}

