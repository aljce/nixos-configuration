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
    nodejs
    tldr
    texlive.combined.scheme-full
    gcc
    rustc
    cargo
    cachix
    google-chrome
    vscode
    stoken
    vlc
    lsof
    qFlipper
    light
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
    jq.enable = true;
    tmux.enable = true;
    obs-studio.enable = true;
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; with pkgs.vscode-utils; [
        vscodevim.vim
        github.copilot-chat
        github.copilot
        mkhl.direnv
        dbaeumer.vscode-eslint   
        esbenp.prettier-vscode   
        jnoortheen.nix-ide 
        justusadam.language-haskell
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "alloglot";
          publisher = "friedbrice";
          version = "2.3.0";
          sha256 = "sha256-Z0izTBG4sx1xXA0wrqCvOE3u0BOCnJB2svkHHHsAJS0=";
        }
        {
          name = "haskell-ghcid";
          publisher = "ndmitchell";
          version = "0.3.1";
          sha256 = "sha256-Ke7P8EJ3ghYG1qyf+w8c2xJlGrRGkJgJwvt0MSb9O+Y=";
        }
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
    };
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
