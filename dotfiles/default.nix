{ stdenv }:
stdenv.mkDerivation {
  name = "dotfiles";
  src = ./.;
  phases = [ "unpackPhase" "buildPhase" ];
  buildPhase = ''
    mkdir $out

    cp ./git/gitconfig $out/.gitconfig

    mkdir $out/.xmonad
    cp ./x/xmonad-config/xmonad.hs $out/.xmonad/xmonad.hs 
    cp ./x/xmobar/xmobarrc $out/.xmobarrc
    cp ./x/resources/Xresources $out/.Xresources
 
    mkdir -p $out/.config/nixpkgs
    cp ./nixpkgs/config.nix $out/.config/nixpkgs/config.nix

    mkdir -p $out/.config/alacritty
    cp ./alacritty/alacritty.yml $out/.config/alacritty/alacritty.yml

    cp ./rtorrent/rtorrent.rc $out/.rtorrent.rc
 '';
}
