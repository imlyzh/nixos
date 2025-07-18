{
  description = "Lyzh's NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix darwin
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    {
      nixosConfigurations = {
        "lyzh-nixos-laptop" = nixpkgs.lib.nixosSystem {
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [ ./machines/configuration.nix ];
        };
      };
      darwinConfigurations = {
        "macbook" = nix-darwin.lib.darwinSystem {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          system = "aarch64-darwin";
          modules = [
            ./machines/macbook-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users.lyzh = {
                imports = [ ./home/darwin-home.nix ./home/shell.nix ./home/dev.nix ];
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
        "macmini" = nix-darwin.lib.darwinSystem {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./machines/macmini-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users.lyzh = {
                imports = [ ./home/darwin-home.nix ./home/shell.nix ./home/dev.nix ];
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        "linux" = home-manager.lib.homeManagerConfiguration rec {
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ./home/shell.nix ./home/dev.nix ];
        };

        "mac" = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/darwin-home.nix ./home/shell.nix ./home/dev.nix ];
        };
      };
    };
}
