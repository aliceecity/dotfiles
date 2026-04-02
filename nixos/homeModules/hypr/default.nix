{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/configs";
in
{
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/hypr";
}
