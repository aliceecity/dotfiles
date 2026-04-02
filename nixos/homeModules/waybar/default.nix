{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file.".config/waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/waybar";
}
