{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    # Basic Command line interfaces
    which
    wget
    tmux
    tree
    emacs
    w3m
    rtorrent
    parted
    ag
    unzip
    xxd
    tcpdump
    vim
    neovim
    gnumake
    parallel

    # Version Control
    git
    gitAndTools.hub
    gist

    # Encryption
    gnupg
    openssl

    # Nix
    nix-prefetch-scripts

    # Fun
    ncmpcpp
    cmatrix
    nethack

    # Battery
    acpi

    # Haskell
    cabal2nix
    stack
    stack2nix
    haskellPackages.stylish-haskell

    # Agda
    (import ./programs/agda {})

    # Latex
    (texlive.combine {
      inherit (texlive) scheme-full;
    })
    aspell
    aspellDicts.en

    # Javascript
    yarn
    yarn2nix
    watchman

    # AWS
    aws
    ec2-api-tools

    # Math
    sage
  ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "root" ];
    };
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "lambda";
    };
  };

  programs.ssh = {
    startAgent = true;
    agentTimeout = "1h";
  };

  programs.gnupg.agent.enable = true;
}
