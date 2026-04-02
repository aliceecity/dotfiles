{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file.".config/tmux/tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/tmux/tmux.conf";
}
