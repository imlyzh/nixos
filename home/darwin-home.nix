{ pkgs,... }:
let
  rosettaPkgs = import pkgs.path {
    system = "x86_64-darwin";
    config.allowUnsupportedSystem = true;
    config.allowUnfree = true;
    # config.allowBroken = true;
  };
in
{
  home = {
    username = "lyzh";
    homeDirectory = "/Users/lyzh";
    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tailscale
    the-unarchiver

    raycast           # 新一代应用启动器
    rectangle         # 开源窗口管理

    iterm2
    zed-editor
    obsidian

    firefox
    discord
    spotify
    transmission_4-gtk
    mumble

    # wineWow64Packages.full
    # wineWow64Packages.stableFull
    # wineWow64Packages.waylandFull
    whisky
    protonplus

    # (rosettaPkgs.clash-verge-rev.overrideAttrs (old: {
    #   meta.platforms = old.meta.platforms ++ ["x86_64-darwin"];
    # }))
    # (rosettaPkgs.v2raya.overrideAttrs (old: {
    #   meta.platforms = old.meta.platforms ++ ["x86_64-darwin"];
    # }))
    # (rosettaPkgs.steam.overrideAttrs (old: {
    #   meta.platforms = old.meta.platforms ++ ["x86_64-darwin"];
    # }))
  ];

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
  };

  programs.direnv = {
    enable = true;
  };

  # home.sessionVariables = {
  #   http_proxy = "";
  #   https_proxy = "";
  #   all_proxy = "";
  #   NO_PROXY = "localhost,127.0.0.1, ::1";
  # };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
  };

  programs.home-manager.enable = true;
}
