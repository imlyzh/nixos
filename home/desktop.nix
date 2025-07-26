# 你可以把这个文件保存为 desktop.nix，然后在你的主 home.nix 中导入它
{ config, pkgs, ... }:

let
  # 在这里定义你的变量，方便修改！
  my-terminal = "kitty";
  my-launcher = "fuzzel";

  # 定义壁纸路径和命令，这样两边可以共用
  wallpaper-path = "${config.home.homeDirectory}/.config/assets/00181.png"; # <-- ★★★ 把这里改成你的壁纸的绝对路径！
  wallpaper-cmd = "${pkgs.swaybg}/bin/swaybg -i ${wallpaper-path}";# -m fill";
in {
  # --------------------------------------------------------------------
  # 安装需要的软件包
  # --------------------------------------------------------------------
  home.packages = with pkgs; [
    noto-fonts-cjk-sans # 中日韩字体，防止乱码
    font-awesome # 好看的图标字体，waybar会用到

    # sway
    swayfx
    niri
    xwayland-satellite
    # Hyprland 的朋友们很多和 Sway 是通用的！
    kitty
    ghostty
    ulauncher
    bibata-cursors

    fuzzel
    waybar
    mako
    swaylock # 锁屏工具
    swayidle # 空闲管理，可以配合锁屏用
    #polkit-gnome
    polkit
    # Sway 可以用 swaybg，但 swww 也很棒！
    swaybg

    grim
    slurp
    wl-clipboard
    pavucontrol

    #fcitx5
    ibus

    firefox
    discord
    spotify
    kotatogram-desktop
    transmission_4-gtk

    clash-verge-rev
    # vscode
    file-roller

    podman-desktop

    obsidian
    logseq
    syncplay
    teamspeak3
    # teamspeak_client
    # teamspeak_server
    # zoom-us
    qbittorrent-enhanced
    localsend
    # steam

    anki
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
  };

  programs.firefox.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        decoration = {
          rounding = 10;
          blur.enabled = true;
          inactive_opacity = 0.9;
          active_opacity = 0.9;
        };
        "exec-once" = [
          "waybar"
          "ghostty"
        ];
        "windowrulev2" = [
          "float, class:^(ulauncher)$"
          "center, class:^(ulauncher)$"
          "noborder, class:^(ulauncher)$"
          "noshadow, class:^(ulauncher)$"
          "rounding 0, class:^(ulauncher)$"
          "noblur, class:^(ulauncher)$"
          "opaque, class:^(ulauncher)$"
        ];
        bind =
          [
            "$mod, F, exec, brave"
            "$mod, RETURN, exec, ghostty"
            "$mod, Q, killactive,"
            "$mod, D, exec, ulauncher"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (builtins.genList (i:
                let ws = i + 1;
                in [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              )
              9)
          );
          binde = [
            "$mod, LEFT, resizeactive, -10 0"
            "$mod, RIGHT, resizeactive, 10 0"
            "$mod, UP, resizeactive, 0 -10"
            "$mod, DOWN, resizeactive, 0 10"
          ];
      };
    };
    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
    home.sessionVariables = {
      HYPRCURSOR_THEME = "Bibata-Modern-Classic";
      HYPRCURSOR_SIZE = "24";
    };
    home.file = {
      "./.config/waybar".source = ../dotfiles/.config/waybar;
      "./.config/assets".source = ../dotfiles/.config/assets;
      "./.config/niri/config.kdl".source = ../dotfiles/.config/niri/config.kdl;
    };
    programs.ghostty = {
      enable = true;
      settings = {
      };
    };
    systemd.user.services.swaybg = {
      Unit = {
        Description = "Sway Background";
        PartOf = "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/.config/assets/00181.png";
        Restart = "on-failure";
        RestartSec = "1";
        TimeoutStopSec = "5";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
