{ pkgs, ... }:
let
  overrides = pkgs.haskell.packages.ghc822.override {
    overrides = self: super: {
      async = self.callPackage ./async.nix {};
      Agda = self.callPackage ./Agda.nix {};
    };
  };
in
overrides.Agda
