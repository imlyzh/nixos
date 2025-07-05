{
  description = "Lyzh's NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    {
      nixosConfigurations = {
        "lyzh-nixos" = nixpkgs.lib.nixosSystem {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = [ ./machines/configuration.nix ];
        };
      };
      darwinConfigurations = {
        "lyzhdeMac" = nix-darwin.lib.darwinSystem {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./machines/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users.lyzh = {
                imports = [ ./home/darwin-home.nix ./home/dev.nix ];
              };
            }
          ];
          specialArgs = { inherit inputs; };
        # nixpkgs-darwin.lib.darwinSystem {
          # pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          # specialArgs = {
            # inherit inputs;
            # inherit home-manager;
            # pkgs = import inputs.nixpkgs {
              # system = "aarch64-darwin";
              # config.allowUnfree = true;
            # };
        };
      };

      homeConfigurations = {
        "lyzh-nix-machine" = home-manager.lib.homeManagerConfiguration rec {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ./home/dev.nix ];
        };

        "lyzhdeMac" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/darwin-home.nix ./home/dev.nix ];
        };
      };
    };
}
