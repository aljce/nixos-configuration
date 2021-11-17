{ pkgs, ... }:
let home-manager = builtins.fetchTarball {
      url = "https://github.com/rycee/home-manager/archive/release-20.09.tar.gz";
      sha256 = "07f903ij0czyhly8kvwjazvz3s6kflxzh5fs6j8781lkxsy47i9f";
    };
in
{ imports = [ "${home-manager}/nixos" ];
}
