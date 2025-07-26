{ pkgs, ... }: {
  home.packages = with pkgs; [
    direnv

    typst

    verilator
    gtkwave

    openjdk

    rustup

    qemu

    lunarvim
    neovim
  ];

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
  };

  programs.direnv = {
    enable = true;
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  xdg.configFile."nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "imlyzh";
      repo = "lazyvim-starter";
      rev = "48688d8db7665d6555c64b8c64b1f4e678d53ab8";
      sha256 = "sha256-mz+OmaaMF+infojTJ6CP6OUVCdThg0Dnm4p6bO5mPiA=";
    };
    recursive = true;
  };
}