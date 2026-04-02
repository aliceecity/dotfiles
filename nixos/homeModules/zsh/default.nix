{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/configs";
in
{
  home.file.".config/zsh/.zshrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zsh/zshrc";
  home.file.".zshenv".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/zsh/zshenv";
}
