{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    # Basic Command line interfaces
    which
    wget
    tmux
    tree
    w3m
    parted
    ag
    unzip
    xxd
    tcpdump
    vim
    gnumake
    parallel
    findutils
  ];
}
