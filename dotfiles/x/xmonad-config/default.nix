{ package ? "xmonad-config", compiler ? "ghc802" }:
let
  pkgs = import <nixpkgs> {};
  filterPredicate = p: type:
    let path = baseNameOf p; in !(
       (type == "directory" && path == "dist")
    || (type == "symlink"   && path == "result")
    || (type == "directory" && path == ".git")
    || (type == "symlink"   && pkgs.lib.hasPrefix "result" path)
    || pkgs.lib.hasSuffix "~" path
    || pkgs.lib.hasSuffix ".o" path
    || pkgs.lib.hasSuffix ".so" path
    || pkgs.lib.hasSuffix ".nix" path);
    
  overrides = pkgs.haskell.packages.${compiler}.override {
    overrides = self: super:
    with pkgs.haskell.lib;
    with { cp = file: (self.callPackage (./nix/haskell + "/${file}.nix") {}); 
           build = name: path: self.callCabal2nix name (builtins.filterSource filterPredicate path) {}; 
         };
    {
      xmonad-config = build "xmonad-config" ./.;
    };
  };
  drv = overrides.${package};
in
if pkgs.lib.inNixShell then drv.env else drv

