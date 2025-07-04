{
  description = "Lyzh's NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-darwin = {
    #   url = "github:LnL7/nix-darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    {
      nixosConfigurations = {
        "lyzh-nixos" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./machines/configuration.nix ];
        };
      };

      darwinConfigurations = {
        "lyzhdeMac" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [ ./machines/darwin-configuration.nix ];
        };
      };

      homeConfigurations = {
        "lyzh-nix-machine" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ];
        };

        "lyzhdeMac" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/darwin-home.nix ];
        };
      };
    };
}
