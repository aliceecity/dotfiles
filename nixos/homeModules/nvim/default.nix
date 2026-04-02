{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim";
}
