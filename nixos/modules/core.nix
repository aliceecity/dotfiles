{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.sudo.extraConfig = ''Defaults pwfeedback'';

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };

  environment.systemPackages = with pkgs; [
    neovim
    tree-sitter
    bat
    fd
    unzip
    zip
    ripgrep
    fzf
    tmux
    fastfetch
    wget

    cargo
    rustc

    gcc

    typst

    btop

    git
    ffmpeg
  ];

  system.stateVersion = "26.05";
}
