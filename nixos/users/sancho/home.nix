{ config, pkgs, ... }:

{

  imports = [
    ../../homeModules/zsh
    ../../homeModules/tmux
    ../../homeModules/nvim
    ../../homeModules/git
    ../../homeModules/hypr
    ../../homeModules/alacritty
    ../../homeModules/waybar
    ../../homeModules/ssh
  ];

  home.packages = with pkgs; [
    grim
    nestopia-ue
    slurp
    wl-clipboard
    brightnessctl
    waybar
    swaybg
    rofi
    yt-dlp
    qview
    btop
    vlc
    chatterino7
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "alice";
      user.email = "aliceecity@proton.me";
    };
  };

  programs.firefox.enable = true;

  home.stateVersion = "25.11";
}
