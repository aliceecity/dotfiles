{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file.".ssh/config".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/ssh/config";
}
