{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file.".config/alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/alacritty";
}
