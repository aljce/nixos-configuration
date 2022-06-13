{ pkgs, config, ... }:
{ boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  mercury = {
    internalCertificateAuthority.enable = true;
    mwbDevelopment = {
      enable = true;
      postgresPackage = pkgs.postgresql_14;
    };
    nixCache.enable = true;
    vpn = {
      enable = true;
      configurationPath = config.sops.secrets.alicePritunlConfig.path;
    };
    # legacyVpn = {
    #   enable = true;
    #   ca = config.sops.secrets.aliceOpenvpnCA.path;
    #   cert = config.sops.secrets.aliceOpenvpnCert.path;
    #   key = config.sops.secrets.aliceOpenvpnKey.path;
    # };
  };
}
