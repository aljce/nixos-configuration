{ pkgs, config, ... }:
{ boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  services.tailscale.enable = true;

  mercury = {
    internalCertificateAuthority.enable = true;
    mwbDevelopment = {
      enable = true;
      postgresPackage = pkgs.postgresql_13;
    };
    nixCache.enable = true;
    # legacyVpn = {
    #   enable = true;
    #   ca = config.sops.secrets.aliceOpenvpnCA.path;
    #   cert = config.sops.secrets.aliceOpenvpnCert.path;
    #   key = config.sops.secrets.aliceOpenvpnKey.path;
    # };
  };

  networking.firewall.checkReversePath = "loose";

  environment.systemPackages = with pkgs; [
    teleport
  ];
}
