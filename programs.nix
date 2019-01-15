{ pkgs, ... }:
let hie-src = pkgs.fetchFromGitHub {
      owner  = "domenkozar";
      repo   = "hie-nix";
      rev    = "8f04568aa8c3215f543250eb7a1acfa0cf2d24ed";
      sha256 = "06ygnywfnp6da0mcy4hq0xcvaaap1w3di2midv1w9b9miam8hdrn";
    };
    hies = import hie-src { inherit pkgs; };
in
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

    neovim

    # Version Control
    git
    gitAndTools.hub
    gist

    # Encryption
    gnupg

    # Scripting
    nix-repl

    # Fun
    ncmpcpp
    cmatrix
    nethack

    # Battery
    acpi

    # Haskell
    cabal2nix
    # cabal-install
    haskellPackages.stylish-haskell
    hies.hie82

    # Agda
    (import ./programs/agda { inherit pkgs; })

    # Latex
    (texlive.combine {
      inherit (texlive) scheme-full;
    })
    aspell
    aspellDicts.en
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
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
}
