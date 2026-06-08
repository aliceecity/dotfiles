{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "abyss";
  networking.networkmanager.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."reg" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "reg";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  programs.zsh.enable = true;

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
     neovim
     gcc
     bat
     fd
     yazi
     unzip
     zip
     ripgrep
     fzf
     tmux
     fastfetch
     hyfetch # this fetching shit gets serious
     alacritty
     wget

     vesktop
     qview
     btop
     vlc
     git
     ffmpeg

     grim
     rofi
     slurp
     swaybg
     wl-clipboard
     waybar

     waywall
     prismlauncher
  ];

  programs.hyprland.enable = true;

  programs.firefox.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  system.stateVersion = "26.05";
}
