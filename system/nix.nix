{ nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = false;
  };
  nix = {
    settings.trusted-users = [
      "alice"
      "root"
    ];
    extraOptions = ''
      experimental-features = flakes nix-command
    '';
  };
}
