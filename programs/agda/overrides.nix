{ pkgs }:

self: super:

with { inherit (pkgs.stdenv) lib; };

with pkgs.haskell.lib;

{
  Agda = (
    with rec {
      AgdaSource = pkgs.fetchFromGitHub {
        repo = "agda";
        owner = "agda";
        rev = "48c9d8fe35adca8c2e309bf64e99b26b25a90169";
        sha256 = "0sj6m75ikdc4adbqm0ladis18l09q92jv3sbcv1r0w7ja2i6z5fh";
      };
      AgdaBasic = dontHaddock (dontCheck (self.callCabal2nix "Agda" AgdaSource { }));
    };
    overrideCabal AgdaBasic (old: {
    })
  );
}
