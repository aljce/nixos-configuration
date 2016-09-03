with import <nixpkgs> { };

haskell.lib.buildStackProject {
  name = "xmonad";
  ghc = haskell.packages.ghc7103.ghc;
  buildInputs = [ ncurses
                  x11
                  xorg.libX11
                  xorg.libXext
                  xorg.libXrandr ];
}
