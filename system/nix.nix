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
    extraOptions = ''
      experimental-features = flakes nix-command
    '';
  };
}
