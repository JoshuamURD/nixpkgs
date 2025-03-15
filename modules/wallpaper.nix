{ config, lib, pkgs, ... }:

let
  wallpaperDir = "${config.home.homeDirectory}/.config/wallpapers";
  defaultWallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-blue.png";
    sha256 = "sha256-AvQGMqFrZpKiGW0f6GpZcHvUOXH5gvRCjvT3YI3oBZM=";
  };
in
{
  home.packages = with pkgs; [
    hyprpaper
    # Add swaybg as fallback
    swaybg
  ];

  # Create hyprpaper config
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = on
    preload = ${wallpaperDir}/default.png
    wallpaper = ,${wallpaperDir}/default.png
    splash = false
  '';

  # Ensure wallpaper directory exists and copy default wallpaper
  home.file = {
    "${wallpaperDir}/.keep".text = "";
    "${wallpaperDir}/default.png".source = defaultWallpaper;
  };
} 