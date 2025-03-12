{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./git.nix
    ./fish.nix
    ./ghostty.nix
    # Add other modules as you create them:
    # ./terminal.nix
    # ./nvim.nix
    # etc...
  ];
} 
