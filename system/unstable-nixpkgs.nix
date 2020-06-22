let unstable-nixpkgs-src = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/ccaa301add0b33b233627d4e974adc4a4b4fd9da.tar.gz";
      sha256 = "1f58plad78kn2fl2mn2c13wb42sv9l274hq8sa5dmlv54m3m94bm";
    };
    unstable-nixpkgs = import unstable-nixpkgs-src {};
in
unstable-nixpkgs
