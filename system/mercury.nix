{ pkgs, ... }:
{ services.postgresql = {
    package = pkgs.postgresql_12;
    enable = true;
    enableTCPIP = false;
    authentication = ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    settings = {
      timezone = "UTC";
      shared_buffers = "128MB";
      fsync = "off";
      synchronous_commit = "off";
      full_page_writes = "off";
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
  # imports = [ ../../mercury/nops/module/module.nix ];
  # sops.enable = true;
  # sops.file = ./test.yaml;
  # sops.secrets = {
  #   foo = {
  #     owner = "alice";
  #   };
  #   aws = {
  #     metadata = {
  #       file = ./test.yaml;
  #     };
  #     dir = {
  #       metadata = {
  #         file = ./test.yaml;
  #       };
  #       foo = {};
  #     };
  #     access_id = {};
  #     secret_id = {};
  #   };
  # };
}
