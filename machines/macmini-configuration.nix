{ config, pkgs, inputs, ... }:
{
  nix.enable = false;

  system.stateVersion = 6;
  system.primaryUser = "lyzh";

  users.users.lyzh = {
    name = "lyzh";
    home = "/Users/lyzh";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
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
  ];

  # nix.gc = {
    # automatic = true;
    # options = "--delete-older-than 30d";
  # };
  system.defaults = {
    universalaccess.reduceMotion = true;

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
      # launchanim = false;
      # expose-animation-duration = 0.1;
      # autohide-delay = 0.0;
      # autohide-time-modifier = 0.0;

      autohide = false;
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
      remapCapsLockToControl = true;
    };
  };
#   environment.variables = {
#     EDITOR = "nvim";
#   };
  programs.zsh.enable = true;
}
