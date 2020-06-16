user: { config, pkgs, ... }:
{ home-manager.users.${user.userid} = {
    services = {
      gpg-agent = {
        enable = true;
        pinentryFlavor = "gtk2";
      };
      keybase.enable = true;
      spotifyd = {
        enable = true;
        settings = {
          global = {
            username = user.email;
            password_cmd = "pass show spotify.com | head -n 1";
            device_name = config.networking.hostName;
          };
        };
      };
    };
    programs = {
      git = {
        enable = true;
        userName = user.legal-name;
        userEmail = user.email;
      };
      gpg.enable = true;
      htop.enable = true;
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions
          (exts: with exts; [ pass-otp pass-checkup pass-update pass-import ]);
      };
      browserpass.enable = true;
      ssh.enable = true;
      texlive.enable = true;
      tmux.enable = true;
      zathura.enable = true;
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        shellAliases = {
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
        };
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "sudo" ];
          theme = "lambda";
        };
      };
    };
  };
}
