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
      
      # Disable fading for better performance
      fading = false;

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
        "_GTK_FRAME_EXTENTS@:c"
      ];
      
      # Backend settings
      backend = "xrender";
      vsync = false;
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-client-opacity = true;
      
      # Performance improvements
      glx-no-stencil = true;
      glx-no-rebind-pixmap = true;
      use-damage = true;
      xrender-sync-fence = true;
      
      # Additional performance settings
      unredir-if-possible = true;
      detect-transient = true;
      detect-client-leader = true;
    };
    
    opacityRules = [
      "80:class_g = 'Alacritty'"
      "90:class_g = 'Firefox'"
      "90:class_g = 'Cursor'"
      "80:class_g *?= 'Ghostty'"
    ];
  };
} 