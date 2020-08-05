{ config, pkgs, ... }:
{ home-manager.users.alice = {
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
            username = "mckean.kylej@gmail.com";
            password_cmd = "pass show spotify.com | head -n 1";
            device_name = config.networking.hostName;
          };
        };
      };
    };
    home.packages = with pkgs; [
      aspell
      aspellDicts.en
      nodejs
      tldr
      nix-deploy
    ];
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
      ssh = {
        enable = true;
        extraConfig = ''
          Host *
            User alice
            IdentityFile ~/.ssh/id_rsa
          Host *
            User mercury
            IdentityFile ~/.ssh/mercury
        '';
      };
      lsd = {
        enable = true;
        enableAliases = true;
      };
      emacs.enable = true; # TODO: Set up spacemacs with home-manager
      jq.enable = true;
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
          "nrs" = "sudo nixos-rebuild switch";
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
