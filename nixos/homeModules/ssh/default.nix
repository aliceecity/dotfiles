{ pkgs, config, ... }:

{
  home.file.".ssh/config".source = ../../../ssh/config;
}
