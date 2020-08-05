{ pkgs, ... }:
{ services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  hardware.ledger.enable = true;
  environment.systemPackages = with pkgs; [
    ledger-live-desktop
    monero-gui
  ];
}
