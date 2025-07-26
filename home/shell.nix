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
    mihomo
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
    syntaxHighlighting.highlighters = [
      "main" "brackets" "pattern" "cursor" "regexp" "root" "line"
    ];
  };
}