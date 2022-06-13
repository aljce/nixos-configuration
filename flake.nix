{
  description = "Alice McKean's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # mercury.url = "git+ssh://git@github.com/mercurytechnologies/nixos-configuration.git?ref=main";
    mercury.url = "/home/alice/repos/mercury/nixos-configuration";
  };
  outputs =
    { nixpkgs
    , home-manager
    , nixos-hardware
    , sops-nix
    , nix-colors
    , mercury
    , ...
    }: {
      nixosConfigurations = {
        neptune = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Base
            ./system

            # Hardware
            ./machines/neptune
            nixpkgs.nixosModules.notDetected

            # Secrets
            sops-nix.nixosModules.sops
            ./sops

            # Mercury
            mercury.nixosModules
            # mercury.roles.aws
            ./mercury

            # Home Manager
            home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.alice = import ./users/alice {
                  inherit nix-colors;
                };
              }
          ];
        };
        saturn = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Modules
            ./system
            ./sops
            ./mercury

            # Hardware
            ./machines/saturn
            nixpkgs.nixosModules.notDetected

            # Secrets
            sops-nix.nixosModules.sops

            # Home Manager
            home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.alice = import ./users/alice {
                  colours = nix-colors;
                };
              }
          ];
        };
      };
    };
}
