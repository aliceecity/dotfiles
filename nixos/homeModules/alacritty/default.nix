{ pkgs, config, ... }:

{
  home.file.".config/alacritty" = {
    source = ../../../alacritty;
    recursive = true;
  };
}
