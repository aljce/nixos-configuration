{ nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://mpickering.cachix.org"
    ];
    binaryCachePublicKeys = [
      "mpickering.cachix.org-1:COxPsDJqqrggZgvKG6JeH9baHPue8/pcpYkmcBPUbeg="
    ];
    trustedUsers = [ "root" "amckean" ];
  };
}
