{ pkgs, ... }:
{
  home = {
    username = "lyzh";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/lyzh" else "/home/lyzh";
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
    git
    neovim
    emacs
    nushell
    ripgrep
    fd
    fzf
    bat
    tailscale
    neofetch

    verilator
    gtkwave
    # vscode

    # clash-meta
    # v2raya
  ];

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
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

  programs.home-manager.enable = true;
}
