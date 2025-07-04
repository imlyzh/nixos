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

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    ripgrep
    neovim

    the-unarchiver

    # raycast           # 新一代应用启动器
    # alfred            # 经典工作流启动器
    # rectangle         # 开源窗口管理

    # vlc
    iterm2
    warp
    # visual-studio-code
    zed-editor
    obsidian
    logseq
    typora

    firefox
    discord
    spotify
    calibre
    transmission-gtk
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
    };
    dock = {
      autohide = true;
      show-recents = true;
      mru-spaces = false;
      appswitcher-all-displays = true;
      expose-group-apps = true;
      scroll-to-open = true;
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
    screencapture = {
      target = "clipboard"; # "file" "preview"
    };
  };
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
#   environment.variables = {
#     EDITOR = "nvim";
#   };
  programs.zsh.enable = true;
}