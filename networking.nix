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
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIDTTCCAjWgAwIBAgIJAK0EmUKwL6kuMA0GCSqGSIb3DQEBCwUAMB4xHDAaBgNV
      BAMME2ludGVybmFsLm1lcmN1cnkuY28wHhcNMTgwOTEzMjIwNDA1WhcNMjgwOTEw
      MjIwNDA1WjAeMRwwGgYDVQQDDBNpbnRlcm5hbC5tZXJjdXJ5LmNvMIIBIjANBgkq
      hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtnLKMgM9mM+ZU2Fm76FZ6jdqaS3f+tKb
      XeMOLMit3okd7d0OSLHTRS+1BMUiTojS3fOpFydbNEtLi8UhBJi9A882VmUAzpQw
      88dTpYerwN4fcwKI8f5viTAfKd2jZRqA32pnHuBURRA3BHprfiLZaIpVy4GC/INV
      kNf0rfxkGFIWOYnWejzINFedyaIlv0tSqjaFxWzvUAlmFGn0YM76EY/0Atq6t4NY
      WIlWbKvHHb5EEfDKfZQyXO/0W8GxvEe89mJzftJjlpaS6Pc+GVocOmM8iP46atbJ
      lUWkjt+BJJHgMzQzdaSXCrWuD/RDjXiMZ409Xcmpu6rL9z++/CELaQIDAQABo4GN
      MIGKMB0GA1UdDgQWBBQ37+mtaGYdRir8ly8k405etSIOATBOBgNVHSMERzBFgBQ3
      7+mtaGYdRir8ly8k405etSIOAaEipCAwHjEcMBoGA1UEAwwTaW50ZXJuYWwubWVy
      Y3VyeS5jb4IJAK0EmUKwL6kuMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMA0G
      CSqGSIb3DQEBCwUAA4IBAQA/3REo4xonRXq9n5iUI6Hr6BF7F4JepmyxrR2MiHrg
      FJxP6a4eel3bsAvRwetjHYeRigXqdFZW90uShHIMEfuma9OY7PPjQohfW17GFLFv
      LZFjPvJD/7PDCHwt3LgkrPjJ/USz2Wc0ng70PHC8FePSTmuL+q6JP9eq/aDFHV/O
      Jahc9vzOnr8vrvrOSbWvLBt663bARzyEVDlRzvj5HX2QTEgN5Ayz/0Yn1QDDYt+1
      aI75riBHC1E/gz1rvjdjPSz5MzfghUCkOHFhdH/bcUaLgEbNHrfE3LiB053rLz5a
      E8N1/RlWqYV9xqLX3Hqq8DhddlWSs6Z65MjNQQWr1DTe
      -----END CERTIFICATE-----
    ''
  ];
}
