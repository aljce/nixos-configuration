{ pkgs, ... }:
let home-manager = builtins.fetchTarball {
      url = "https://github.com/rycee/home-manager/archive/release-20.09.tar.gz";
      sha256 = "0cxnh7g1nagmdkl40jsg5kvfq6mdpg21k7b9y0i713p6zsgd48jl";
    };
in
{ imports = [ "${home-manager}/nixos" ];
}
