{ pkgs, config, ... }:
with {
  unstable-nixpkgs = import ./unstable-nixpkgs.nix {};
};
{ boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  services.postgresql = {
    package = unstable-nixpkgs.postgresql_13;
    enable = true;
    enableTCPIP = false;
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    extraPlugins = [config.services.postgresql.package.pkgs.postgis];
    settings = {
      timezone = "UTC";
      shared_buffers = 128;
      fsync = false;
      synchronous_commit = false;
      full_page_writes = false;
    };
  };
  services.openvpn.servers = {
    mercury = {
      autoStart = false;
      updateResolvConf = true;
      config = ''
        remote vpn.mercury.com 1194 udp
        nobind
        dev tun
        persist-tun
        persist-key
        compress
        pull
        auth-user-pass
        tls-client
        ca /etc/vpn/alice/ca.crt
        cert /etc/vpn/alice/alice.crt
        key /etc/vpn/alice/alice.key
        remote-cert-tls server
        auth-nocache
        reneg-sec 0
      '';
    };
    pritunl = {
      autoStart = false;
      updateResolvConf = true;
      config = builtins.readFile ./pritunl.ovpn;
    };
  };
  security.pki.certificateFiles = [
    (builtins.toFile "internal.mercury.com.ca.crt" ''
      internal.mercury.com
      -----BEGIN CERTIFICATE-----
      MIIDUDCCAjigAwIBAgIJAOPnjalJGnpNMA0GCSqGSIb3DQEBCwUAMB8xHTAbBgNV
      BAMMFGludGVybmFsLm1lcmN1cnkuY29tMB4XDTIwMDIxOTAyMDg1NVoXDTMwMDIx
      NjAyMDg1NVowHzEdMBsGA1UEAwwUaW50ZXJuYWwubWVyY3VyeS5jb20wggEiMA0G
      CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCsSdAVzYQsZWO3FVhl/nIXwNnqrrUB
      hpkfBrCKspf+rRRrSf9/3G6i9enSAHSs8/HAQjUPNT+5367IfybgbFINZl2QLtyb
      QFOWe+ADskG8d1S5wVd7FhgefY+UACHd5mWG8SsAjUxO5Un6RWbVl5z3hILtxVHx
      UUGepepYVWukAoz77dYqkVM9ymy3XSxsg7CXrSbPEAIVNRxTMF2ADL/ZqSYA1A3w
      Pb55k62U7+rnOe8SbBdpS18z+koCthjaX/cWRvJ2Sg7K3BqURtVKq3GJRJPENGdc
      1nvKsH5UYCh5W641BLx89SHXFShH+pev5p7V5VX6TIrTDeq1WK2CJ1DDAgMBAAGj
      gY4wgYswHQYDVR0OBBYEFMxJZhpAC5Wh464DErgVtJla5pazME8GA1UdIwRIMEaA
      FMxJZhpAC5Wh464DErgVtJla5pazoSOkITAfMR0wGwYDVQQDDBRpbnRlcm5hbC5t
      ZXJjdXJ5LmNvbYIJAOPnjalJGnpNMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEG
      MA0GCSqGSIb3DQEBCwUAA4IBAQANVp9pjCnUyDABXrBtQGYf8p3Z13/ZvGJjvd0o
      ParXJ42kYkZvwjUjvOw4/vWtlLOx0uum6ldep1+kFVgLNFxiJ1ogbo8K8MWhel5j
      gmDNMX8ccFhWTccgXTpag3zv71bSbbEXRw0PnauyBoE2vTMCKg68LSsNaCmwRix9
      1UbJi9qhRxBZtjd0LqdX2o2tKRtWmiMJeLH2ZytqZY60EMNYwpOFAy7edE1+ZpZn
      IgWF3vBzHhQZta3BqAUg8F9OOjNj/aZ3eEA7XTbxGFrOn7MCrqKzNWqHfjunThBX
      NxZEHtlSSfOTziaZDi182WAMEBW6Ob2icKB/FW7gfgOpCVc3
      -----END CERTIFICATE-----
      ''
    )
  ];
}
