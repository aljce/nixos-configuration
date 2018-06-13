let hostname = builtins.replaceStrings [ "\n" ] [ "" ] (builtins.readFile ./hostname);
in
{ imports = [ (./machines + "/${hostname}.nix") ];

  networking.hostName = hostname;
}
