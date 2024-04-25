{
  description = "Alice McKean's NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kolide = {
      url = "github:kolide/nix-agent/main";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
    nix-colors.url = "github:misterio77/nix-colors";
    mercury.url = "git+ssh://git@github.com/mercurytechnologies/nixos-configuration.git?ref=main";
  };
  outputs =
    { nixpkgs
    , home-manager
    , nixos-hardware
    , sops-nix
    , nix-colors
    , mercury
    , kolide
    , ...
    }: {
      nixosConfigurations = {
        neptune = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Base
            ./system
            ./system/steam.nix

            # Hardware
            ./machines/neptune
            nixpkgs.nixosModules.notDetected

            # Secrets
            sops-nix.nixosModules.sops
            ./sops

            # Mercury
            mercury.nixosModules
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
            # Base
            ./system

            # Hardware
            ./machines/saturn
            nixpkgs.nixosModules.notDetected

            # Secrets
            sops-nix.nixosModules.sops
            ./sops

            # Mercury
            mercury.nixosModules
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
        jupiter = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Hardware
            machines/jupiter
            ./system
            ./system/sway.nix
            ./system/fingerprint.nix
            
            # Kolide
            ./system/kolide.nix
            kolide.nixosModules.kolide-launcher

            # Secrets
            sops-nix.nixosModules.sops
            ./sops

            # Mercury
            mercury.nixosModules
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

      };
    };
}
