{ pkgs, ... }:
let unstable-nixpkgs = import ./unstable-nixpkgs.nix;
in
{ hardware.ledger.enable = true;
  environment.systemPackages = with pkgs; [
    ledger-live-desktop
    unstable-nixpkgs.pkgs.monero-gui
  ];
}
