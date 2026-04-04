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
    nestopia-ue
    vesktop
    yt-dlp
    qview
    btop
    vlc
    chatterino7
    git
    ffmpeg
  ];

  programs.firefox.enable = true;

  home.stateVersion = "25.11";
}
