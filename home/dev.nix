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
      rev = "f381332de4b988bf58fcc3084c61e727ce174302";
      sha256 = "sha256-/s8Las2x3A/Zd0OkjkBP1Zxtzv99lS5MEbgM+vaWSzg=";
    };
    recursive = true;
  };
}