# 你可以把这个文件保存为 desktop.nix，然后在你的主 home.nix 中导入它
{ config, pkgs, ... }:

let
  # 在这里定义你的变量，方便修改！
  my-terminal = "kitty";
  my-launcher = "fuzzel";

  # 定义壁纸路径和命令，这样两边可以共用
  wallpaper-path = "/home/lyzh/Pictures/00181.png"; # <-- ★★★ 把这里改成你的壁纸的绝对路径！
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
    # wofi

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

    spotify
    firefox
    # vscode
    file-roller
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 14;
    };
  };

  programs.firefox.enable = true;
  # --------------------------------------------------------------------
  # SwayFX 的配置
  # --------------------------------------------------------------------
  # wayland.windowManager.sway = {
  #   package = pkgs.swayfx;
  #   extraConfig = ''
  #     set $mod Mod4
  #     set $term ${my-terminal}
  #     set $menu ${my-launcher}
  #     exec ${wallpaper-cmd}
  #     exec waybar
  #     corner_radius 10
  #     blur enable
  #     shadows enable
  #   '';
  # };

  # programs.waybar = {
  #   enable = true;
  #   style = ''
  #     * {
  #       border: none;
  #       font-family: "Noto Sans CJK SC", "Font Awesome 6 Free";
  #       font-size: 16px;
  #       min-height: 0;
  #     }
  #     window#waybar {
  #       background: rgba(30, 30, 46, 0.85);
  #       color: #cdd6f4;
  #     }
  #     #workspaces button.active {
  #       background-color: #b48ead;
  #       color: #1e1e2e;
  #     }
  #     #clock, #cpu, #memory, #pulseaudio, #network {
  #       padding: 0 10px;
  #     }
  #   '';
  #   settings = {
  #     mainBar = {
  #       layer = "top";
  #       position = "top";
  #       height = 35;
  #       modules-left = ["sway/workspaces" "sway/mode"];
  #       modules-center = ["sway/window"];
  #       modules-right = ["pipewire" "network" "cpu" "memory" "clock"];
  #       "clock" = { "format" = " {:%Y-%m-%d %H:%M}"; };
  #       "cpu" = { "format" = " {usage}%"; };
  #       "memory" = { "format" = " {}%"; };
  #       "network" = { "format-wifi" = "  {essid}"; "format-disconnected" = "󰖪"; };
  #       # "pulseaudio" = { "format" = "{icon} {volume}%"; "format-icons" = { "default" = ["", "", ""]; }; };

  #       # 然后在 mainBar 里添加 pipewire 的配置
  #       "pipewire" = {
  #         "format" = "{icon} {volume}%";
  #         "format-muted" = "󰖁 Muted"; # 静音图标
  #         "format-icons" = ["", "", ""];
  #       };
  #     };
  #   };
  # };

  programs.ghostty.enable = true;
  # programs.waybar.enable = true;
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Sway Background";
      PartOf = "graphical-session.target";
    };
    Service = {
      ExecStart = wallpaper-cmd;
      Restart = "on-failure";
      RestartSec = "1";
      TimeoutStopSec = "5";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.file = {
    "./.config/niri/config.kdl".source = ../dotfiles/.config/niri/config.kdl;
    "./.config/waybar".source = ../dotfiles/.config/waybar;
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };
}
