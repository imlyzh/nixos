# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs,... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    useUserPackages = true;
    sharedModules = [../home/home.nix];
    users.lyzh = {};
  };

  nix = {
    settings = {
      substituters = [
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        # "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.supportedFilesystems = [ "btrfs" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "lyzh-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:20171";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.tailscale.enable = true;
  services.v2raya.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.lyzh = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      uid = 1001;
      hashedPassword = "$6$3EPkfBlo6DmngTcl$fxPkkvpjjSyAniQoZ2roAGCvgKXG51e824SDEr3FtMXX.E4h3qIxsNMLI6d0KZeAvLQrtgUkbu4m1dLeYJ11H.";
      packages = with pkgs; [];
    };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      btrfs-progs

      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #neovim
      #emacs

      wget
      curl

      #direnv

      git
      #zsh
      #fish

      #gcc
      cmake
      ninja

      code-server

      tailscale
      #clash-meta
      v2raya
      proxychains-ng
    ];

  environment.variables = {
    RUSTUP_HOME = "\${HOME}/.rustup";
    CARGO_HOME = "\${HOME}/.cargo";
    CC = "clang";
    CXX = "clang++";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    # any other system-level libraries vscode-server might need
  ];

  #programs.vscode.server.enable = true;

  #environment.sessionVariables = {
  #  # 代理服务器地址
  #  PROXY_HOST = "127.0.0.1";
  #  PROXY_PORT = "20170";
  #  # HTTP/HTTPS 代理
  #  http_proxy  = "http://${config.environment.sessionVariables.PROXY_HOST}:${config.environment.sessionVariables.PROXY_PORT}";
  #  https_proxy = "http://${config.environment.sessionVariables.PROXY_HOST}:${config.environment.sessionVariables.PROXY_PORT}";
  #  # 如果是 SOCKS5 代理
  #  #https_proxy = "socks5://${config.environment.sessionVariables.PROXY_HOST}:20171";
  #  # 不走代理的地址
  #  no_proxy = "localhost,127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.local,100.64.0.0/10";
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.samba = {
    enable = true;
    settings = {
      public = {
        browseable = "yes";
        comment = "Public samba share.";
        "guest ok" = "yes";
        path = "/home/lyzh/Music";
        "read only" = "yes";
      };
    };
    # openFirewall = true;
  };

  services.nfs.server = {
    enable = true;
    exports = "/home/lyzh/Music *.*.*.*(rw,fsid=0,no_subtree_check)";
    hostName = "lyzh-nixos";
  };

  #services.nfs.server = {
  #  enable = true;
  #  openFirewall = true;
  #}

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
