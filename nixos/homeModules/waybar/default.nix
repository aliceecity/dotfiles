{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/configs";
in
{
  home.file.".config/waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/waybar";
}
