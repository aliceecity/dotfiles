{ config, pkgs, ... }:

{

  imports = [
    ../../homeModules/zsh
    ../../homeModules/tmux
  ];

  home.packages = with pkgs; [
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
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  programs.firefox.enable = true;

  home.stateVersion = "25.11";
}
