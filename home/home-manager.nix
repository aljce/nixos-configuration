{ pkgs, ... }:
let home-manager = builtins.fetchTarball {
      url = "https://github.com/rycee/home-manager/archive/release-20.03.tar.gz";
      sha256 = "0m7b8cazlcci3bi1j99cpgq10qp6mjml6v11jlfabh05kpyswqkk";
    };
    nur-src = builtins.fetchTarball {
      url = "https://github.com/nix-community/NUR/archive/2f738e78193dd04c0499e4d52bb81264ebad2862.tar.gz";
      sha256 = "0ww3k68jfjxhmb6lrlwg065h2lgs1dnh259s9nw1l7hzfyy2b23w";
    };
    nur = import nur-src { inherit pkgs; };
in
{ imports = [ "${home-manager}/nixos" ];
  nixpkgs.config.packageOverrides = pkgs: { inherit nur; };
}
