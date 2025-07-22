{ pkgs, ... }: {
  home.packages = with pkgs; [
    direnv

    typst

    verilator
    gtkwave

    openjdk

    rustup
    # zig

    qemu
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
}