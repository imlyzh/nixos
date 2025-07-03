#{ config, pkgs, ... }:
{ pkgs, ... }:
{
  home = {
    username = "lyzh";
    homeDirectory = "/home/lyzh";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    rsync
    ripgrep
    fd
    
    neofetch
    htop
    btop

    neovim
    emacs

    wget
    curl
      
    direnv

    git
    zsh
    fish

    gnumake
    cmake
    ninja

    jdk17
    sbt
    mill
    verilator
    gtkwave

    llvmPackages_latest.llvm
    llvmPackages_latest.bintools

    rustup

    ghc
    cabal-install
    haskell-language-server

    vscode
    
    #tailscale
    #clash-meta
    #v2raya
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

  home.sessionVariables = {
    http_proxy = "";
    https_proxy = "";
    all_proxy = "";
    NO_PROXY = "localhost,127.0.0.1, ::1";
  };

  programs.home-manager.enable = true;
}
