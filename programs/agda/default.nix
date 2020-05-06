{ compiler ? "ghc883" }:
let fetchNixpkgs = import ./fetchNixpkgs.nix;
    nixpkgs-src = fetchNixpkgs {
      owner  = "NixOS";
      repo   = "nixpkgs";
      rev    = "5272327b81ed355bbed5659b8d303cf2979b6953"; # 20.23
      sha256 = "0182ys095dfx02vl2a20j1hz92dx3mfgz2a6fhn31bqlp1wa8hlq";
    };
    nixpkgs = import nixpkgs-src {
      config = {
        packageOverrides = super: let self = super.pkgs; in {
          haskellPackages = super.haskell.packages.${compiler}.override {
            overrides = import ./overrides.nix { pkgs = self; };
          };
        };
      };
      overlays = [ ];
    };
in
nixpkgs.haskellPackages.Agda
