{
  description = "Lyzh's NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    deploy-rs.url = "github:serokell/deploy-rs";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, rust-overlay, deploy-rs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.deploy = deploy-rs.apps.${system}.default;
    }) // {
      deploy = {
        nodes = {
          "lyzh-nixos-laptop" = {
            hostname = "lyzh-nixos";
            sshUser = "lyzh";
            useSudo = true;
            # buildOnTarget = true;
            # magicRollback = false;
            profiles = {
              system = {
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations."lyzh-nixos-laptop";
              };
            };
          };
        };
      };

      # 所有系统配置都放在这里，它们不依赖于当前用的是什么电脑
      nixosConfigurations = {
        "lyzh-nixos-laptop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # 明确指定目标系统
          specialArgs = { inherit inputs; };
          modules = [
            ./machines/configuration.nix
            home-manager.nixosModules.home-manager
            {
              # home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lyzh = {
                imports = [ ./home/home.nix ./home/shell.nix ./home/dev.nix ./home/desktop.nix];
              };
            }
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
          ];
        };
      };

      darwinConfigurations = {
        "macbook" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/macbook-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users.lyzh = {
                imports = [ ./home/darwin-home.nix ./home/shell.nix ./home/dev.nix ];
              };
            }
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
          ];
          specialArgs = { inherit inputs; };
        };
        "macmini" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/macmini-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.users.lyzh = {
                imports = [ ./home/darwin-home.nix ./home/shell.nix ./home/dev.nix ];
              };
            }
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
          ];
          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        "linux-desktop" = home-manager.lib.homeManagerConfiguration rec {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/home.nix
            ./home/shell.nix
            ./home/dev.nix
            ./home/desktop.nix
            ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
            ];
        };

        "linux" = home-manager.lib.homeManagerConfiguration rec {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/home.nix
            ./home/shell.nix
            ./home/dev.nix
            ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
            ];
        };

        "mac" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/darwin-home.nix
            ./home/shell.nix
            ./home/dev.nix
            ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
            ];
        };
      };
    };
}
