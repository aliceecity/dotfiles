{ config, pkgs, ... }:

{

  imports = [
    ../../homeModules/zsh
    ../../homeModules/tmux
    ../../homeModules/git
    ../../homeModules/hypr
    ../../homeModules/alacritty
    ../../homeModules/waybar
  ];

  home.packages = with pkgs; [
    brightnessctl
    waybar
    hyprpaper
    rofi
    yt-dlp
    qview
    streamlink
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
