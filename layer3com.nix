{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    socat
  ];
  services.rsyslogd = {
    enable = true;
    defaultConfig = ''
      $ModLoad imjournal
      *.* @127.0.0.1:4000"
    '';
  };
}
