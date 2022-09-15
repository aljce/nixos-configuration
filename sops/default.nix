{ ... }:
{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      rootPassword = {
        neededForUsers = true;
        path = "/etc/passwords/root";
      };
      alicePassword = {
        neededForUsers = true;
        path = "/etc/passwords/alice";
      };
      aliceOpenvpnCA = {
        path = "/etc/vpn/alice/ca.crt";
      };
      aliceOpenvpnCert = {
        path = "/etc/vpn/alice/alice.crt";
      };
      aliceOpenvpnKey = {
        path = "/etc/vpn/alice/alice.key";
      };
      alicePritunlConfig = {
        path = "/etc/vpn/alice/pritunl.ovpn";
      };
    };
  };
}
