{ pkgs, ... }: {
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
    neofetch
    dust
    tmux
    coreutils
  ];

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
  };
}