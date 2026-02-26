{ pkgs, config, ... }:

{
  home.file.".config/git/" = {
    source = ../../../git;
    recursive = true;
  };
}
