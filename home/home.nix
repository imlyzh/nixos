{ config, lib, pkgs, isDarwin ? false, ... }:
{
  imports = [
    ./common.nix
  ] ++ (
    lib.optional isDarwin ./darwin.nix
  ) ++ (
    lib.optional (!isDarwin) ./nixos.nix
  );

  home.username = "lyzh";
  home.homeDirectory = if isDarwin then "/Users/lyzh" else "/home/lyzh";
}