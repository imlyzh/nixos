# /etc/nixos/configuration.nix
# 小狐娘帮你改造好啦！

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
        "https://cache.nixos.org/"
      ];
    };
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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
    enable = true;
    # type = "fcitx5";
    # fcitx.engines = with pkgs.fcitx-engines; [ rime ];
    # fcitx5.enableRimeData= true;
    # fcitx5.addons = with pkgs; [
    #   fcitx5-rime
    #   # fcitx5-chinese-addons
    #   # fcitx5-gtk
    # ];
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      rime
    ];
  };

  fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      sarasa-gothic  #更纱黑体
      source-code-pro
      hack-font
      fira-code
      jetbrains-mono
    ];

  # --- 小狐娘在这里做了大改造哦！ ---
  # 1. 我们不再需要 Xorg 服务和 GDM 啦，Sway 会自己处理好一切
  # services.xserver.enable = true; # 注释掉
  # services.displayManager.gdm.enable = true; # 注释掉
  # programs.hyprland.enable = true; # 把 Hyprland 也收起来

  # 2. 换上轻巧漂亮的 greetd 登录管理器！
  services.greetd = {
    enable = true;
    # package = pkgs.greetd.tuigreet;
    settings = {
      #tuigreet = {
      #  kb_command = "F10";
      #  kb_session = "F11";
      #  kb_power = "F12";
      #  power_no_setsid = true;
      #  remember_user_session = true;
      #};
      default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-session --cmd niri";
    };
  };

  # 3. 这是 Sway 的魔法配置区！(当前启用)
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      autotiling-rs
    ];
  };

  programs.niri.enable = true;

  programs.waybar.enable = true; # launch on startup in the default setting (bar)
  services.gnome.gnome-keyring.enable = true; # secret service
  # services.polkit-gnome.enable = true; # polkit
  # security.polkit.enable = true; # polkit
  security.soteria.enable = true; # polkit agent

  # 5. Wayland 世界的“胶水”程序，非常重要！
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    # 如果发现截图或文件选择有问题，可以把下面这个也打开
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.xserver.xkb.options = "caps:escape";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };
  # 色彩配置服务
  services.colord.enable = true;

  # 地理位置服务
  services.geoclue2.enable = true;

  services.tailscale.enable = true;
  services.v2raya.enable = true;

  services.gvfs.enable = true; # 磁盘挂载

  users.users.lyzh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1001;
    hashedPassword = "$6$3EPkfBlo6DmngTcl$fxPkkvpjjSyAniQoZ2roAGCvgKXG51e824SDEr3FtMXX.E4h3qIxsNMLI6d0KZeAvLQrtgUkbu4m1dLeYJ11H.";
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs

    greetd.tuigreet
    sway
    swayfx
    niri
    # Hyprland 的朋友们很多和 Sway 是通用的！
    kitty
    wofi

    alacritty
    fuzzel
    swaylock
    waybar
    mako
    swaylock # 锁屏工具
    swayidle # 空闲管理，可以配合锁屏用
    #polkit-gnome
    polkit
    # swww # Sway 可以用 swaybg，但 swww 也很棒！
    swaybg

    grim
    slurp
    wl-clipboard

    fcitx5

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
  ];

  programs.firefox.enable = true;

  programs.kdeconnect.enable = true;

  # kde 磁盘管理软件，仅仅添加到 systemPackages 是用不了，需要 suid 提权
  programs.partition-manager.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  # 压缩解压
  programs.file-roller.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables = {
    RUSTUP_HOME = "\${HOME}/.rustup";
    CARGO_HOME = "\${HOME}/.cargo";
    CC = "clang";
    CXX = "clang++";

    # 输入法环境变量，非常重要！
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
    INPUT_METHOD = "ibus";
    SDL_IM_MODULE = "ibus";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

  services.openssh.enable = true;
  # services.samba = {
  #   enable = true;
  #   settings = {
  #     public = {
  #       browseable = "yes";
  #       comment = "Public samba share.";
  #       "guest ok" = "yes";
  #       path = "/home/lyzh/Music";
  #       "read only" = "yes";
  #     };
  #   };
  # };
  # services.nfs.server = {
  #   enable = true;
  #   exports = "/home/lyzh/Music 0.0.0.0(rw,fsid=0,no_subtree_check)";
  #   hostName = "lyzh-nixos";
  # };
  networking.firewall.enable = false;
  system.stateVersion = "25.05";
}
