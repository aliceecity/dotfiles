{ pkgs, config, ... }:

{
  home.file.".config/zsh/.zshrc".source = ./zshrc;
}
