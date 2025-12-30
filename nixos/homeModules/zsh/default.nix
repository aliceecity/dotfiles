{ pkgs, config, ... }:

{
  home.file.".config/zsh/.zshrc".source = ./zshrc;
  home.file.".zshenv".source = ./zshenv;
}
