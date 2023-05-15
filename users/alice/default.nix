{ nix-colors, nix-doom-emacs }: { pkgs, config, ... }:
{ imports = [
    nix-colors.homeManagerModule
    nix-doom-emacs.hmModule
    ./programs.nix
    # ./wayland.nix
  ];
  colorScheme = nix-colors.colorSchemes.stella;
  home.stateVersion = "22.11";
}
