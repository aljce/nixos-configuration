{ config, pkgs, ... }:
{ services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };
  };
  home.packages = with pkgs; [
    (aspellWithDicts (d: [ d.en ]))
    haskellPackages.Agda
    nodejs-16_x
    tldr
    texlive.combined.scheme-full
    gcc
    rustc
    cargo
    cachix
    google-chrome
    vscode
    stoken
  ];
  programs = {
    git = {
      enable = true;
      userName = "Alice McKean";
      userEmail = "mckean.kylej@gmail.com";
      extraConfig = {
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
      extraConfig = ''
        Host *
          User alice
          IdentityFile ~/.ssh/id_rsa
        Host *
          User mercury
          IdentityFile ~/.ssh/mercury
        Host *.internal.mercury.com
          StrictHostKeyChecking=no
        Host 10.*.*.*
          StrictHostKeyChecking=no
      '';
    };
    lsd = {
      enable = true;
      enableAliases = true;
    };
    doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom;
    };
    jq.enable = true;
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
