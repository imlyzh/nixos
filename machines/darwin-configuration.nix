{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    ripgrep
    neovim
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
  system.defaults = {
    finder = {
      _FXShowPosixPathInTitle = true; # 在标题栏显示完整路径
      AppleShowAllExtensions = true;   # 显示所有文件扩展名
    };
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
    };
  };
#   environment.variables = {
#     EDITOR = "nvim";
#   };
  programs.zsh.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.lyzh = { pkgs, ... }: {
    imports = [ "../home/home.nix" ];

    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "robbyrussell";
      };
    #   shellAliases = {
    #     ll = "ls -l";
    #     update = "darwin-rebuild switch --flake ~/.config/nix-darwin-config";
    #   };
    };

    # home.sessionVariables = {
    #   LANG = "en_US.UTF-8";
    # };
  };
}