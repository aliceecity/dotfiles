{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     alacritty

     qbittorrent
     vesktop
     qview
     mpv

     grim
     rofi
     slurp
     swaybg
     wl-clipboard
     waybar
     pavucontrol
  ];

  programs.hyprland.enable = true;

  programs.firefox.enable = true;

  services.printing.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
