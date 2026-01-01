{ pkgs, config, ... }:

{
  home.file.".config/tmux/tmux.conf".source = ../../../tmux/tmux.conf;
}
