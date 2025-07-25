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
      rev = "803bc181d7c0d6d5eeba9274d9be49b287294d99";
      sha256 = "QrpnlDD4r1X4C8PqBhQ+S3ar5C+qDrU1Jm/lPqyMIFM=";
    };
    recursive = true;
  };
}