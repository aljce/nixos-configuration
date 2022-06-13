{ pkgs, lib, ... }:
with lib.cli;
let swayfont = "source-code-pro 10";
    modifier = "Mod1";
    colors = import ./colors.nix { inherit lib; };
in
{   wayland.windowManager.sway = {
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
          border = colors.hex colors.primary;
          text = colors.hex colors.light;
          childBorder = colors.hex colors.primary;
          indicator = colors.hex colors.accent;
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
          "${modifier}+Shift+s" = "move scratchpad";
          "${modifier}+s" = "scratchpad show";
        };
        workspaceAutoBackAndForth = true;
        modes = {
          power = {
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
        ];
      };
    };
    home.packages = with pkgs; [
      # swaylock-effects
      xwayland
      wl-clipboard
      rofi
      waybar
      signal-desktop
      spotify
      discord
      libnotify
      slurp
      grim # wayland screenshot application that works
      imv # wayland image viewer that works
      pdfpc # pdf presentation viewer run with -s -S
    ];
    xdg.configFile."environment.d/envvars.conf".text = ''
      MOZ_ENABLE_WAYLAND=1
    '';
    programs = {
      firefox = {
        enable = true;
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
        };
      };
      mako = {
        enable = true;
        anchor = "top-right";
        backgroundColor = colors.hex colors.dark;
        textColor = colors.hex colors.light;
        borderColor = colors.hex colors.primary;
        borderRadius = 5;
        borderSize = 2;
        font = "SourceCodePro 18";
      };
      rofi.enable = true;
    };
}

