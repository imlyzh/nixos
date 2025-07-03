{ pkgs, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neofetch
    htop
    btop

    neovim
    emacs

    wget
    curl

    direnv

    zsh

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
