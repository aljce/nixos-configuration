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
    binaryCaches = [ "http://cache.nixos.org" "https://cache.mercury.com" "https://hercules-ci-enterprise.cachix.org" ];
    binaryCachePublicKeys = [ "cache.mercury.com:yhfFlgvqtv0cAxzflJ0aZW3mbulx4+5EOZm6k3oML+I=" "hercules-ci-enterprise.cachix.org-1:HxQqd37HOwQHNQTSx3BTjJfjO5QkZORT8FzEH6Dr+kU=" ];
    extraOptions = ''
      netrc-file = /etc/nix/netrc
    '';
  };
}
