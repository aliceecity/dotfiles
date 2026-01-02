{ pkgs, config, ... }:

{

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main"; # woke
      core.editor = "nvim";
    };
  };

}
