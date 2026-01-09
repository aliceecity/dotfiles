{ config, pkgs, ... }:

{

  imports = [
    ../../homeModules/zsh
    ../../homeModules/tmux
    ../../homeModules/git
  ];

  home.packages = with pkgs; [
    hyprlauncher
    yt-dlp
    qview
    streamlink
    btop
    vlc
    discordo
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
