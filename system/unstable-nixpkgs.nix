let unstable-nixpkgs-src = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/e2508a8e57eb8a6478f2b39fc5c7106654cfea41.tar.gz";
      sha256 = "0ifvcpyjqg8bh46aa94c7d26pbgb2vnn32bqa5ikgx8zdrl5p5fh";
    };
    unstable-nixpkgs = import unstable-nixpkgs-src { config.allowUnfree = true; };
in
unstable-nixpkgs
