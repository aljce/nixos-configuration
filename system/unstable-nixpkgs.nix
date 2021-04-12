let unstable-nixpkgs-src = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/e8ee6c35110d21286cde2ad2e5f85db133bb95cf.tar.gz";
      sha256 = "1vbhpqgdpf0ncd7yal49kp7fv1fngd8rk7jg82pfzidx155f8xmf";
    };
    unstable-nixpkgs = import unstable-nixpkgs-src { config.allowUnfree = true; };
in
unstable-nixpkgs
