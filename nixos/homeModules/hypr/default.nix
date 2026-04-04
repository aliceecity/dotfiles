{ pkgs, config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles/configs";
in
{

  home.packages = with pkgs; [
    grim
    rofi
    slurp
    swaybg
    wl-clipboard
    brightnessctl
  ];

  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/hypr";
}
