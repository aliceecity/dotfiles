{ pkgs, config, ... }:

{
  home.file.".config/waybar" = {
    source = ../../../waybar;
    recursive = true;
  };
}
