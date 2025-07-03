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
    let
      system = "x86_64-linux"; # "aarch64-linux", "aarch64-darwin", etc.
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        "lyzh-nixos" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [ ./machines/configuration.nix ];
        };
      };

      homeConfigurations = {
        "lyzh-nix-machine" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home/home.nix ];
        };

        # "lyzh@lyzhdeMac" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        #   extraSpecialArgs = { inherit inputs; };
        #   modules = [ ./home/darwin.nix ];
        # };
      };

      # (可选) 如果完整地用 Nix 管理 macOS 系统
      # darwinConfigurations = {
      #   "lyzh@lyzhdeMacBook-Air" = nix-darwin.lib.darwinSystem {
      #     system = "aarch64-darwin";
      #     specialArgs = { inherit inputs; };
      #     modules = [
      #       # ... macOS 系统配置
      #       # 同样可以集成 home-manager
      #       home-manager.darwinModules.home-manager
      #       {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users.lyzh = import ./home/home.nix;
      #       }
      #     ];
      #   };
      # };
    };
}
