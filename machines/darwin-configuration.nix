{ config, pkgs, inputs, ... }:
{
#   imports = [ inputs.home-manager.darwinModules.home-manager ];

#   home-manager = {
#     useGlobalPkgs = true;
#     useUserPackages = true;
#     users.lyzh = ../home/darwin-home.nix;
#   };
  system.stateVersion = 6;
  system.primaryUser = "lyzh";

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    ripgrep
    neovim
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
  system.defaults = {
    finder = {
      AppleShowAllFiles = true;
      _FXShowPosixPathInTitle = true; # 在标题栏显示完整路径
      AppleShowAllExtensions = true;   # 显示所有文件扩展名
      FXDefaultSearchScope = "SCcf";
      NewWindowTarget = "Home";
      QuitMenuItem = true;
      ShowMountedServersOnDesktop = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXSortFoldersFirst = true;
      FXEnableExtensionChangeWarning = false;
    };
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
    };
  };
#   environment.variables = {
#     EDITOR = "nvim";
#   };
  programs.zsh.enable = true;
}