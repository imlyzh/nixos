{ pkgs, ... }: {
  home.packages = with pkgs; [
    podman
    podman-tui
  ];
}