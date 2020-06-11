user: { config, pkgs, ... }:
{ home-manager.users.${user.userid} = {
    services = {
      gpg-agent = {
        enable = true;
        pinentryFlavor = "tty";
      };
      keybase.enable = true;
      spotifyd = {
        enable = false;
        settings = {
          global = {
            username = user.username;
            password = "secret";
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
