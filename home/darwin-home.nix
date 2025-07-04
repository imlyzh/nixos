{ pkgs, ... }:
{
  home = {
    username = "lyzh";
    homeDirectory = "/Users/lyzh";
    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    rsync
    zsh
    fish
    wget
    curl
    htop
    btop
    tlrc
    tree
    git
    neovim
    emacs
    nushell
    ripgrep
    fd
    jq
    fzf
    bat
    tailscale
    neofetch
    dust
    typst

    direnv

    verilator
    gtkwave
    vscode

    openjdk

    rustup

    the-unarchiver

    # raycast           # 新一代应用启动器
    # alfred            # 经典工作流启动器
    # rectangle         # 开源窗口管理

    vlc
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

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
  };

  programs.direnv = {
    enable = true;
  };

  #programs.rustup = {
  #  enable = true;
  #  toolchains = "stable";
  #};

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
