{ config, pkgs, ... }:
{ home-manager.users.alice = {
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
            username = "mckeankylej";
            password = "secret";
            device_name = config.networking.hostName;
          };
        };
      };
    };
    programs = {
      git = {
        enable = true;
        userName = "Alice McKean";
        userEmail = "mckean.kylej@gmail.com";
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
