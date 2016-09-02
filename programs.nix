{ config, pkgs, ... }:
{ nixpkgs.config.allowUnfree = true;

  programs = {
    zsh.enable = true;
    light.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Basic Command line interfaces
    which
    wget
    tmux
    tree
    vim
    emacs
    w3m
    rtorrent
    parted
    ag
    unzip
    rxvt_unicode

    # Version Control
    git
    gitAndTools.hub

    # Encryption
    openssl
    gnupg
    pass

    # Scripting
    python
    nix-repl

    # Fun
    ncmpcpp
    cmatrix
    nethack

    # Emacs
    pythonPackages.html2text
    imagemagick
    offlineimap
    msmtp
    mu
    ledger
    reckon

    haskellPackages.apply-refact
    haskellPackages.hlint
    haskellPackages.hindent
    # (hunspellWithDicts [hunspellDicts.en-us])

    # Haskell
    stack
    cabal-install
    cabal2nix

    # Rust
    rustc
    cargo

    # Web Development
    nodejs
    npm2nix
    nodePackages.gulp
    nodePackages.bower
    haskellPackages.purescript
  ];
}
