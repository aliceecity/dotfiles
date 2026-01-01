{ pkgs, config, ... }:

{
  home.file.".config/zsh/.zshrc".source = ../../../zsh/zshrc;
  home.file.".zshenv".source = ../../../zsh/zshenv;
}
