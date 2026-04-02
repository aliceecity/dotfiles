{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/configs";
in
{
  home.file.".config/git".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/git";
}
