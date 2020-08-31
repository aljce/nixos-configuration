{ nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };
  nix = {
    trustedUsers = [
      "alice"
      "root"
    ];
    binaryCaches = [ "http://cache.nixos.org" "https://cache.mercury.com" ];
    binaryCachePublicKeys = [ "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=" ];
  };
}
