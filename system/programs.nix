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
    haskellPackages.stylish-haskell

    # Latex
    aspell
    aspellDicts.en

    # Javascript
    yarn
    watchman

    # AWS
    aws

    # Math
    # sage
  ];
}
