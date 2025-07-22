# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs,... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    useUserPackages = true;
    sharedModules = [../home/home.nix ../home/dev.nix ../home/shell.nix];
    users.lyzh = {};
  };

  nix = {
    settings = {
      substituters = [
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.supportedFilesystems = [ "btrfs" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "lyzh-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://localhost:20171";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8"; # «--- 小狐娘建议开启这个，对很多程序有好处
  i18n.extraLocaleSettings = { # «--- 小狐娘帮你把中文环境也配好啦
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  i18n.inputMethod = {
    # 这是根据警告信息修改的，更现代的写法！
    enable = true;
    type = "fcitx5";
    # 我们把插件列表写得更精确，就不会找不到了！
    fcitx5.addons = [
      pkgs.fcitx5-chinese-addons
      pkgs.fcitx5-gtk
      # pkgs.fcitx5-qt  # «--- 看！我们告诉了它完整的路径 pkgs.fcitx5-qt！
    ];
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # «--- 小狐娘在这里做了改动哦！ ---»
  # 我们保留 GDM 作为登录器，但禁用完整的 GNOME 桌面，这样更轻量
  services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true; # «--- 注释掉这个！

  # «--- 小狐娘在这里添加了 Hyprland 的核心配置 ---»
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # «--- 小狐娘帮你启用了 Pipewire 来管理声音 ---»
  # services.pulseaudio.enable = true; # 这个是旧的，我们不用啦
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;    # 让老程序也能用
    alsa.support32Bit = true;
    jack.enable = true;    # 专业音频支持
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.tailscale.enable = true;
  services.v2raya.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lyzh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    uid = 1001;
    hashedPassword = "$6$3EPkfBlo6DmngTcl$fxPkkvpjjSyAniQoZ2roAGCvgKXG51e824SDEr3FtMXX.E4h3qIxsNMLI6d0KZeAvLQrtgUkbu4m1dLeYJ11H.";
    packages = with pkgs; [];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    btrfs-progs
    vim
    wget
    curl
    git
    code-server
    vscode
    tailscale
    clash-verge-rev
    v2raya
    proxychains-ng

    # «--- 小狐娘在这里加上了 Hyprland 的好朋友们！ ---»
    waybar       # 漂亮的状态栏
    kitty        # 一个速度很快的终端
    wofi         # 应用启动器 (可以换成 rofi-wayland)
    mako         # 通知弹窗
    swww         # 设置壁纸的小可爱
    swaylock     # 锁屏工具
    grim         # 截图工具
    slurp        # 截图时用来选择区域的
    wl-clipboard # Wayland 的剪贴板工具

    # «--- 小狐娘贴心推荐的输入法 ---»
    fcitx5
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  environment.variables = {
    RUSTUP_HOME = "\${HOME}/.rustup";
    CARGO_HOME = "\${HOME}/.cargo";
    CC = "clang";
    CXX = "clang++";

    # «--- 小狐娘在这里添加了输入法需要的环境变量 ---»
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    SDL_IM_MODULE = "fcitx";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    # any other system-level libraries vscode-server might need
  ];

  #programs.vscode.server.enable = true;

  #environment.sessionVariables = { ... }; # 主人这里原来是注释掉的，小狐娘就没动它

  # List services that you want to enable:
  services.openssh.enable = true;
  services.samba = {
    enable = true;
    settings = {
      public = {
        browseable = "yes";
        comment = "Public samba share.";
        "guest ok" = "yes";
        path = "/home/lyzh/Music";
        "read only" = "yes";
      };
    };
    # openFirewall = true;
  };
  services.nfs.server = {
    enable = true;
    exports = "/home/lyzh/Music 0.0.0.0(rw,fsid=0,no_subtree_check)";
    hostName = "lyzh-nixos";
  };
  networking.firewall.enable = false;
  system.stateVersion = "25.05"; # Did you read the comment?
}
