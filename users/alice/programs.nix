{ config, pkgs, ... }:
{ services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
    };
  };
  home.packages = with pkgs; [
    aspell
    aspellDicts.en
    (agda.withPackages (ps: with ps; [ standard-library cubical ]))
    nodejs-16_x
    tldr
    texlive.combined.scheme-full
    gcc
    rustc
    cargo
    cachix
    google-chrome
  ];
  programs = {
    git = {
      enable = true;
      userName = "Alice McKean";
      userEmail = "mckean.kylej@gmail.com";
      extraConfig = {
        alias.merge = "merge --no-edit"; # no editor popup on merge
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
    emacs = {
      enable = true;
      package = pkgs.emacs28Packages.emacs;
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
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "lambda";
      };
    };
  };
}
