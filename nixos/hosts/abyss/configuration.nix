{ config, pkgs, inputs, ... }:
let
  mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/core.nix
      ../../modules/desktop.nix
      ../../modules/locale.nix
    ];

  networking.hostName = "abyss";
  networking.networkmanager.wifi.powersave = false;
  boot.kernelModules = [ "8821ce" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl8821ce ];

  users.users."reg" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "reg";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = (with pkgs; [
     hyfetch

     krita

     waywall
     prismlauncher
     jdk21
     obs-studio
  ]) ++ [
     mcsrPkgs.ninjabrain-bot
  ];
}
