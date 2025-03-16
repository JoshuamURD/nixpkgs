{ config, lib, pkgs, ... }:

let
  wallpaperDir = "${config.home.homeDirectory}/.config/nixpkgs/wallpapers";
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  # Create hyprpaper config
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = on
    preload = ${wallpaperDir}/skeletons.png
  wallpaper = ,${wallpaperDir}/skeletons.png
    splash = false
  '';
} 