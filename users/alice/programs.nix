{ config, pkgs, ... }:
{ home.packages = with pkgs; [
    (aspellWithDicts (d: [ d.en ]))
    haskellPackages.Agda
    nodejs
    tldr
    texlive.combined.scheme-full
    gcc
    rustc
    cargo
    cachix
    google-chrome
    stoken
    vlc
    lsof
    qFlipper
    light
    zoom-us
  ];
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "Alice McKean";
        user.email = "mckean.kylej@gmail.com";
        pull.rebase = "false";
        alias.merge = "merge --no-edit"; # no editor popup on merge
        push.autoSetupRemote = "true";
      };
    };
    gpg.enable = true;
    htop.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          identityFile = [ "~/.ssh/id_rsa" "~/.ssh/mercury" ];
        };
        "*.internal.mercury.com" = {
          extraOptions = {
            StrictHostKeyChecking = "no";
          };
        };
        "10.*.*.*" = {
          extraOptions = {
            StrictHostKeyChecking = "no";
          };
        };
      };
    };
    lsd = {
      enable = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
    tmux.enable = true;
    obs-studio.enable = true;
    vscode = {
      enable = true;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        # extensions = with pkgs.vscode-extensions; with pkgs.vscode-utils; [
        #   vscodevim.vim
        #   github.copilot-chat
        #   github.copilot
        #   mkhl.direnv
        #   dbaeumer.vscode-eslint
        #   esbenp.prettier-vscode
        #   jnoortheen.nix-ide
        # ];
        userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
      };
    };
    zathura.enable = true;
    zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "nrs" = "sudo nixos-rebuild switch";
        "vpn" = "sudo tailscale up --accept-routes";
        "mwb" = "cd ~/repos/mercury/mercury-web-backend";
        "infra" = "cd ~/repos/mercury/infrastructure";
        "nd" = "nix develop";
        "ns" = "nix-shell";
        "nb" = "nix build";
        "ag" = "rg";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "lambda";
      };
    };
  };
}
