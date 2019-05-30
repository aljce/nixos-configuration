{ networking.networkmanager.enable = true;
  services.openvpn.servers = {
      mercury = {
        config = ''
          #viscosity startonopen false
          #viscosity usepeerdns true
          #viscosity dns automatic
          #viscosity protocol openvpn
          #viscosity autoreconnect true
          #viscosity name vpn.mercury.co
          #viscosity dhcp true
          remote vpn.mercury.co 1194 udp
          nobind
          dev tun
          persist-tun
          persist-key
          compress
          pull
          auth-user-pass
          tls-client
          ca /etc/vpn/mercury/ca.crt
          cert /etc/vpn/mercury/amckean.crt
          key /etc/vpn/mercury/amckean.key
          remote-cert-tls server
          auth-nocache
          reneg-sec 0
        '';
        autoStart = false;
        updateResolvConf = true;
      };
  };
}
