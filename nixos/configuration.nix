{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "lethe";
  networking.networkmanager.enable = true;

  # Localization stuff
  console.keyMap = "es";
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.xserver.xkb = {
    layout = "es";
      variant = "nodeadkeys";
  };

  programs.hyprland = {
    enable = true;
    # withUWSM = true;
  };

  services.seatd.enable = true;
  #
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session.command = "bash -lc Hyprland";
  #   };
  # };

  # services.xserver.xkb = {
  #   layout = "es";
  #   variant = "nodeadkeys";
  # };

  security.sudo.extraConfig = ''Defaults pwfeedback'';

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.sancho = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "sancho";
    extraGroups = [ "video" "input" "seat" "networkmanager" "wheel" ];
  };

  programs.zsh.enable = true;

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 10";
    };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  fonts.packages = with pkgs; [ 
    nerd-fonts.fira-code
  ];

  environment.systemPackages = with pkgs; [
    bat # nicer cat
    fd # faster find
    yazi
    gnumake
    ripgrep
    fzf
    tmux
    neovim
    typst
    gcc
    fastfetch
    alacritty
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    ports = [ 31200 ];
  };

  system.stateVersion = "25.05";

}
