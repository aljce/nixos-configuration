let unstable-nixpkgs-src = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/162864341d89434fb74e82bd43efa17ca915241b.tar.gz";
      sha256 = "0vqyxiiq9z80hkhxczpslz4gnlgkir15zg0dq38ylgb3kv0nsl6c";
    };
    unstable-nixpkgs = import unstable-nixpkgs-src { config.allowUnfree = true; };
in
unstable-nixpkgs
