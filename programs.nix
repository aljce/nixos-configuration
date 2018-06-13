{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
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

    # Supported Terminal Emulators
    rxvt_unicode

    # Version Control
    git
    gitAndTools.hub

    # Encryption
    gnupg

    # Scripting
    nix-repl

    # Fun
    ncmpcpp
    cmatrix
    nethack
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
  
