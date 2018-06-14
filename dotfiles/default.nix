{ stdenv }:
stdenv.mkDerivation {
  name = "dotfiles";
  src = ./.;
  phases = [ "unpackPhase" "buildPhase" ];
  buildPhase = ''
    mkdir $out

    cp ./git/gitconfig $out/.gitconfig

    mkdir $out/.xmonad
    cp ./x/xmonad-config/app/xmonad.hs $out/.xmonad/xmonad.hs 
    cp ./x/xmobar/xmobarrc $out/.xmobarrc
    cp ./x/resources/Xresources $out/.Xresources
 '';
}
