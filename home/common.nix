{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rsync
    ripgrep
    fd
    fzf
    bat
    fish
    git
  ];

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
  };
}