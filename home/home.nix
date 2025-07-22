{ pkgs, ... }:
{
  home = {
    username = "lyzh";
    homeDirectory = "/home/lyzh";
    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tailscale
    clash-verge-rev
    v2raya
    podman
  ];

  programs.direnv = {
    enable = true;
  };

  programs.home-manager.enable = true;
}
