{ nix-colors, nixpkgs-unstable }: { pkgs, config, ... }:
{ imports = [
    nix-colors.homeManagerModule
    ./programs.nix
    ./wayland.nix
    (import ./vscode.nix { inherit nixpkgs-unstable; })
  ];
  colorScheme = nix-colors.colorSchemes.stella;
  home.sessionPath = [
    "${config.home.profileDirectory}/bin"
  ];
  home.stateVersion = "23.11";
}
