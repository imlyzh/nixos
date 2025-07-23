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
    clash-verge-rev
    v2raya
    podman
    zsh
  ];

  programs.direnv = {
    enable = true;
  };

  programs.home-manager.enable = true;

  #programs.zsh = {
  #  shellAliase = {
  #    code = "code --enable-features=UseOZonePlatform --ozone-platform=wayland";
  #  };
  #};
  home.file.".config/Code/argv.json".text = ''
    {
      "enable-features": "UseOzonePlatform",
      "ozone-platform": "wayland"
    }
  '';
}
