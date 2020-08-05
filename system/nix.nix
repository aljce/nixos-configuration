{ nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
  nix = {
    trustedUsers = [
      "alice"
      "root"
    ];
  };
}
