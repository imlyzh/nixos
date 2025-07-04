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
    # devenv

    verilator
    gtkwave
    # vscode

    openjdk

    rustup

    # clash-meta
    # v2raya
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

  programs.home-manager.enable = true;
}
