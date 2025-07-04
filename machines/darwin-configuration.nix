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
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    NSGlobalDomain.NSUseAnimatedFocusRing = false;
    ActivityMonitor.IconType = 0;
    WindowManager = {
      EnableTiledWindowMargins = false;
      GloballyEnabled = true;
    };
    controlcenter = {
      BatteryShowPercentage = true;
      wvous-bl-corner = 7;
    };
    finder = {
      AppleShowAllFiles = true;
      _FXShowPosixPathInTitle = true; # 在标题栏显示完整路径
      AppleShowAllExtensions = true;   # 显示所有文件扩展名
      FXDefaultSearchScope = "SCcf";
      NewWindowTarget = "Home";
      QuitMenuItem = false;
      ShowMountedServersOnDesktop = true;
      ShowPathbar = true;
      ShowStatusBar = false;
      _FXSortFoldersFirst = true;
      FXEnableExtensionChangeWarning = false;
    };
    dock = {
      autohide = true;
      show-recents = true;
      mru-spaces = false;
      appswitcher-all-displays = true;
      expose-group-apps = true;
      scroll-to-open = true;
      wvous-bl-corner = 1;
    };
  };
#   environment.variables = {
#     EDITOR = "nvim";
#   };
  programs.zsh.enable = true;
}