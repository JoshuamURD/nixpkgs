{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom;
    
    shadow = false;
    
    settings = {
      # Opacity settings
      inactive-opacity = 0.9;
      active-opacity = 1.0;
      frame-opacity = 0.9;
      inactive-opacity-override = false;


      # Optimized blur settings for minimal performance impact
      blur = {
        method = "dual_kawase";
        strength = 3;  # Reduced from 10 to 3 for better performance
        background = true;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };
      
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];      
      # Disable fading for better performance
      fading = false;

      
      # Additional performance settings
      unredir-if-possible = true;
      detect-transient = true;
      detect-client-leader = true;
    };
    
    opacityRules = [
      "80:class_g = 'Alacritty'"
      "90:class_g = 'Firefox'"
      "80:class_g *?= 'Ghostty'"
    ];
  };
} 