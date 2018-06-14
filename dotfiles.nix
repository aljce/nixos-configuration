{ pkgs, ... }:
let dotfiles = pkgs.callPackage ./dotfiles {};
in
{ system.activationScripts.dotfiles = ''
    # symlink all the files in $1 to $2, $1 needs to be an absolute path
    linkdir() {
      for f in $(find $1 -maxdepth 1 -type f -printf '%P\n'); do
        ln -s -f -v $1/$f $2/$f;
      done
    }

    # recursively symlink all the files in $1 to $2
    reclink () {
      linkdir $1 $2
      for d in $(find $1 -type d -printf '%P\n'); do
        mkdir -p -v $2/$d;
        linkdir $1/$d $2/$d;
      done
    };

    reclink ${dotfiles} /home/amckean

    unset -f reclink
    unset -f linkdir
  '';
}
