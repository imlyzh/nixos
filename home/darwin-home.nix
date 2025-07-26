{ pkgs,... }:
# let
#   rosettaPkgs = import pkgs.path {
#     system = "x86_64-darwin";
#     config.allowUnsupportedSystem = true;
#     config.allowUnfree = true;
#     # config.allowBroken = true;
#   };
# in
{
  home = {
    username = "lyzh";
    homeDirectory = "/Users/lyzh";
    stateVersion = "25.05";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tailscale
    the-unarchiver

    raycast           # 新一代应用启动器
    rectangle         # 开源窗口管理

    iterm2
    syncplay
    iina
    qbittorrent-enhanced
    localsend
    disk-inventory-x
    appcleaner
    keycastr
    ollama

    zed-editor

    obsidian
    # logseq
    # teamspeak3
    # teamspeak_client
    # teamspeak_server

    firefox
    discord
    spotify
    telegram-desktop
    transmission_4-gtk
    mumble

    whisky
    protonplus

    v2raya
  ];
  programs.home-manager.enable = true;
}
