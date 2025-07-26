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
      rev = "bd7a72bc0fe7ab3b7da162cb0c06ee751f928667";
      sha256 = "sha256-60OtwT8Dv880taKdstFZ35/7Fn7q/oJ6VGPC/TchfLs=";
      # rev = "f381332de4b988bf58fcc3084c61e727ce174302";
      # sha256 = "sha256-/s8Las2x3A/Zd0OkjkBP1Zxtzv99lS5MEbgM+vaWSzg=";
    };
    recursive = true;
  };
}