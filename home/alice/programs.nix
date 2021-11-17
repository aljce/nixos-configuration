{ config, pkgs, ... }:
with {
  unstableNixpkgs = import ../../system/unstable-nixpkgs.nix;
};
{ home-manager.users.alice = {
    services = {
      gpg-agent = {
        enable = true;
        pinentryFlavor = "gtk2";
      };
    };
    home.packages = with pkgs; [
      aspell
      aspellDicts.en
      (unstableNixpkgs.agda.withPackages (ps: with ps; [ standard-library cubical ]))
      # (agda.overrideAttrs (old: {
      #   Agda = pkgs.haskellPackages.Agda.overrideAttrs (old: {
      #     src = pkgs.fetchFromGitHub {
      #       owner = "agda";
      #       repo = "agda";
      #       rev = "2.6.2";
      #       sha256 = "0c9ngshjdkvhyz59nhg5h5rd5mvv6dzfq1jg732bqg627jm2wwgz";
      #     };
      #   });
      # }))
      nodejs
      tldr
      texlive.combined.scheme-full
      gcc
      rustc
      cargo
      cachix
      direnv
    ];
    programs = {
      git = {
        enable = true;
        userName = "Alice McKean";
        userEmail = "mckean.kylej@gmail.com";
        extraConfig = {
          alias.merge = "merge --no-edit"; # no editor popup on merge
        };
      };
      gpg.enable = true;
      htop.enable = true;
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions
          (exts: with exts; [ pass-otp pass-checkup pass-update pass-import ]);
      };
      browserpass.enable = true;
      ssh = {
        enable = true;
        extraConfig = ''
          Host *
            User alice
            IdentityFile ~/.ssh/id_rsa
          Host *
            User mercury
            IdentityFile ~/.ssh/mercury
          Host *.internal.mercury.com
            StrictHostKeyChecking=no
          Host 10.*.*.*
            StrictHostKeyChecking=no
        '';
      };
      lsd = {
        enable = true;
        enableAliases = true;
      };
      emacs.enable = true; # TODO: Set up spacemacs with home-manager
      jq.enable = true;
      tmux.enable = true;
      zathura.enable = true;
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        shellAliases = {
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "nrs" = "sudo nixos-rebuild switch";
        };
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "sudo" ];
          theme = "lambda";
        };
      };
    };
  };
}
