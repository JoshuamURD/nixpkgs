{ config, lib, pkgs, ... }:

{
  # Create the wallpapers directory and link the wallpapers
  home.file.".config/wallpapers/skeletons.png".source = ../wallpapers/skeletons.png;
  home.file.".config/wallpapers/train.png".source = ../wallpapers/train.png;
  home.file.".config/wallpapers/manhattan.png".source = ../wallpapers/manhattan.png;

  # Configure nitrogen
  home.file.".config/nitrogen/bg-saved.cfg".text = ''
    [xin_-1]
    file=/home/joshuam/.config/wallpapers/skeleton.jpg
    mode=5
    bgcolor=#000000
  '';

  # Add nitrogen configuration directory
  home.file.".config/nitrogen/nitrogen.cfg".text = ''
    [geometry]
    posx=0
    posy=0
    sizex=800
    sizey=600

    [nitrogen]
    view=icon
    recurse=true
    sort=alpha
    icon_caps=false
    dirs=/home/joshuam/.config/wallpapers;
  '';
} 