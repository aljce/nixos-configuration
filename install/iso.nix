{ nixpkgs ? <nixpkgs>, system ? "x86_64-linux" }:
let configuration =
    { pkgs, ... }:
    let partition = pkgs.writeScriptBin "partition" "${./partition}";
    in
    { imports = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        ../system/programs.nix
      ];
      environment.systemPackages = [
        partition
      ];
    };
    iso-image = import "${nixpkgs}/nixos" { inherit system configuration; };
in
iso-image.config.system.build.isoImage
