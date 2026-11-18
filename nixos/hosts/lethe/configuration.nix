{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/core.nix
      ../../modules/desktop.nix
      ../../modules/locale.nix
      ../../modules/uni.nix
    ];

  networking.hostName = "lethe";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  users.users.sancho = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "sancho";
    extraGroups = [ "video" "input" "seat" "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    bluetuith
  ];
}
