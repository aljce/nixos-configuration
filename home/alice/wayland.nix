{ pkgs, lib, ... }:
with lib.cli;
let swayfont = "source-code-pro 10";
    modifier = "Mod1";
    colors = import ./colors.nix { inherit lib; };
    swaylock-effects = pkgs.callPackage ../packages/swaylock-effects.nix {};
    swaylock-config = toGNUCommandLineShell {} {
      screenshots = true;
      clock = true;
      indicator = true;
      show-failed-attempts = true;
      ignore-empty-password = true;
      grace = 2;
      effect-blur = "7x5";
      effect-vignette = "0.6:0.6";
      ring-color = colors.hex colors.primary;
      ring-ver-color = colors.hex colors.green;
      ring-wrong-color = colors.hex colors.red;
      key-hl-color = colors.hex colors.accent;
      line-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      inside-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      separator-color = "00000000";
      text-color = colors.hex colors.light;
    };
    swaylock-command = "swaylock ${swaylock-config}";
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
        colors.focused = {
          background = colors.hex colors.dark;
          border = colors.hex colors.accent;
          text = colors.hex colors.light;
          childBorder = colors.hex colors.accent;
          indicator = colors.hex colors.secondary;
        };
        window.border = 2;
        inherit modifier;
        keybindings = {
          "${modifier}+d" = "exec rofi -show run | xargs swaymsg exec --";
          "${modifier}+c" = "kill";
          "${modifier}+Shift+r" = "reload";
          "${modifier}+f" = "fullscreen";
          "${modifier}+Return" = "exec alacritty";
          "${modifier}+w" = "exec firefox";
          "${modifier}+p" = "mode power";
          "${modifier}+n" = "exec makoctl dismiss";
          "${modifier}+Shift+n" = "exec makoctl dismiss -a";

          "${modifier}+Ampersand" = "workspace number 1";
          "${modifier}+BracketLeft" = "workspace number 2";
	  "${modifier}+BraceLeft" = "workspace number 3";
	  "${modifier}+BraceRight" = "workspace number 4";
	  "${modifier}+ParenLeft" = "workspace number 5";
	  "${modifier}+Equal" = "workspace number 6";
	  "${modifier}+Asterisk" = "workspace number 7";
	  "${modifier}+ParenRight" = "workspace number 8";
	  "${modifier}+Plus" = "workspace number 9";

	  "${modifier}+Shift+Ampersand" = "move container to workspace number 1, workspace number 1";
	  "${modifier}+Shift+BracketLeft" = "move container to workspace number 2, workspace number 2";
	  "${modifier}+Shift+BraceLeft" = "move container to workspace number 3, workspace number 3";
	  "${modifier}+Shift+BraceRight" = "move container to workspace number 4, workspace number 4";
	  "${modifier}+Shift+ParenLeft" = "move container to workspace number 5, workspace number 5";
	  "${modifier}+Shift+Equal" = "move container to workspace number 6, workspace number 6";
	  "${modifier}+Shift+Asterisk" = "move container to workspace number 7, workspace number 7";
	  "${modifier}+Shift+ParenRight" = "move container to workspace number 8, workspace number 8";
	  "${modifier}+Shift+Plus" = "move container to workspace number 9, workspace number 9";
        };
        workspaceAutoBackAndForth = true;
        modes = {
          power = {
            "l" = "exec ${swaylock-command}, mode default";
            "e" = "exit";
            "r" = "exec systemctl reboot";
            "s" = "exec systemctl poweroff -i";
            "p" = "mode default";
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        };
        bars = [];
        startup = [
          { command = "exec systemctl --user restart waybar.service";
            always = true;
          }
          { command = ''
              swayidle -w \
                timeout 300 '${swaylock-command}' \
                timeout 600 'swaymsg "output * dpms off"' \
                      resume 'swaymsg "output * dpms on"' \
            '';
            always = false;
          }
        ];
      };
    };
    services = {
      waybar = {
        enable = true;
        settings = builtins.toJSON [{
          layer = "bottom";
          position = "top";
          height = 40;
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ "sway/window" ];
          modules-right = [ "clock" ];
          "sway/window" = {
            format = "{}";
            max-length = 50;
          };
          "sway/mode" = {
            format = "{}";
          };
          clock = {
            format = "{:%H:%M}";
            tooltip-format = "{:%Y-%m-%d | %H:%M}";
            format-alt = "{:%Y-%m-%d}";
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
            background: ${colors.css colors.dark 0.5}; 
            border-bottom: 3px solid ${colors.css colors.accent 0.5};
            color: ${colors.hex colors.light};
          }
          window#waybar.hidden {
            opacity: 0.0;
          }
          #workspaces button {
            padding: 0 5px;
            background: transparent;
            color: ${colors.hex colors.light};
            border-bottom: 3px solid transparent;
          } 
          #workspaces button.focused {
            background: ${colors.hex colors.accent};
            border-bottom: 3px solid ${colors.hex colors.dark};
          }
          #workspaces button.urgent {
            background-color: ${colors.hex colors.red};
          }
          #clock, #cpu, #memory, #temperature, #backlight, #network, #pulseaudio, #mode, #idle_inhibitor {
            padding: 0 10px;
            margin: 0 5px;
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
      swaylock-effects
      xwayland
      wl-clipboard
      rofi
      waybar
      signal-desktop
      spotify-tui
      libnotify
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
        anchor = "top-right";
        backgroundColor = colors.hex colors.secondary;
        textColor = colors.hex colors.light;
        borderColor = colors.hex colors.accent;
        borderRadius = 5;
        borderSize = 2;
        font = "SourceCodePro 18";
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

