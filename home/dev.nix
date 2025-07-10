{ pkgs, ... }: {
  home.packages = with pkgs; [
    direnv

    typst

    verilator
    gtkwave

    openjdk

    rustup
    zig
  ];

  programs.git = {
    enable = true;
    userName = "imlyzh";
    userEmail = "enterindex@gmail.com";
  };
}