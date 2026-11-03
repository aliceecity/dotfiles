{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jdk21
    virtualbox
  ];
}
