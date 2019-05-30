{ compiler ? "ghc864" }:
let fetchNixpkgs = import ./fetchNixpkgs.nix;
    nixpkgs-src = fetchNixpkgs {
      owner  = "NixOS";
      repo   = "nixpkgs";
      rev    = "6a3a05560a41371977671935ef3d926c6a5225fa";
      sha256 = "08w0vny70pmz6zvpw9y32md502n2758r05qy6hrd5gszg523zqas";
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
