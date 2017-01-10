{ pkgs, ... }:
{ environment.systemPackages = with pkgs; [
    net_snmp
  ];

  services.graphite = {
    web = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 3005;
    };
    carbon = {
      enableCache = true;
      enableRelay = true;
    };
  };
}
