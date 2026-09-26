{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/core.nix
      ../../modules/desktop.nix
      ../../modules/locale.nix
    ];

  networking.hostName = "lethe";

  users.users.sancho = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "sancho";
    extraGroups = [ "video" "input" "seat" "networkmanager" "wheel" ];
  };
}
