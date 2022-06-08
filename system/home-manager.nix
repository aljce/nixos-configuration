{ pkgs, ... }:
let home-manager = builtins.fetchTarball {
      url = "https://github.com/rycee/home-manager/archive/release-22.05.tar.gz";
      sha256 = "1bn5m4qlzxc5c264hwyy9n8f7m1pzc79fd0xh18n46wn0v8vx4jn";
    };
in
{ imports = [ "${home-manager}/nixos" ];
  home-manager.useGlobalPkgs = true;
}
