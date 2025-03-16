{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#89B4FA";
        separator_color = "frame";
        font = "Iosevka Nerd Font 11";
        corner_radius = 10;
        frame_width = 1;
      };

      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 5;
      };

      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
        timeout = 0;
      };
    };
  };
} 