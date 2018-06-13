{ stdenv }:
stdenv.mkDerivation {
  name = "dotfiles";
  src = ./.;
  phases = [ "unpackPhase" "buildPhase" ];
  buildPhase = ''
    mkdir $out
    cp ./git/gitconfig $out/.gitconfig
  '';
}
