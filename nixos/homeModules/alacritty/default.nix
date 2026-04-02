{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/configs";
in
{
  home.file.".config/alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/alacritty";
}
