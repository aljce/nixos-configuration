{ nix-colors }: { pkgs, config, ... }:
{ imports = [
    nix-colors.homeManagerModule
    ./programs.nix
    ./wayland.nix
  ];
  colorScheme = nix-colors.colorSchemes.stella;
  home.stateVersion = "23.11";
}
