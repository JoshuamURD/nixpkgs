{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./git.nix
    ./fish.nix
    ./ghostty.nix
    ./waybar.nix
    ./wallpaper.nix
  ];
} 
