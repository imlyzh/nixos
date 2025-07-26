{ pkgs, ... }:
{
  home = {
    username = "lyzh";
    homeDirectory = "/home/lyzh";
    stateVersion = "25.05";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tailscale
    v2raya
    podman
    zsh

    clang
    zig
  ];

  programs.direnv = {
    enable = true;
  };

  programs.home-manager.enable = true;
    # backupFileExtension = "backup";

  home.file = {
    # ".config/niri/config.kdl".source = ../dotfiles/.config/niri/config.kdl;
    ".config/Code/argv.json".source = ../dotfiles/.config/Code/argv.json;
  };
}
