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
        rev = "8eb0d01811a663cf2b27b482b3b18690adfa094b";
        sha256 = "18kf2q6j8y605hw1byjil49wf3dvm2m98wq6kr5qpk9k8pw51ghz";
      };
      AgdaBasic = dontHaddock (dontCheck (self.callCabal2nix "Agda" AgdaSource { }));
    };
    overrideCabal AgdaBasic (old: {
    })
  );
}
