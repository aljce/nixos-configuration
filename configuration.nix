let hostname = builtins.replaceStrings [ "\n" ] [ "" ] (builtins.readFile ./hostname);
in
{ imports = [
     ./hardware-configuration.nix
     (./machines + "/${hostname}.nix")
  ];

  networking.hostName = hostname;
}
