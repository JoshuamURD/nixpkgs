{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      modules-left = ["hyprland/workspaces" "hyprland/window"];
      modules-center = ["clock"];
      modules-right = ["pulseaudio" "network" "battery" "tray"];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          default = "";
          active = "";
          urgent = "";
        };
      };

      clock = {
        format = "{:%Y-%m-%d %H:%M}";
        tooltip-format = "<big>{:%A, %B %d, %Y}</big>";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " Muted";
        format-icons = {
          default = ["" "" ""];
        };
      };

      network = {
        format-wifi = " {essid}";
        format-ethernet = " {ifname}";
        format-disconnected = " Disconnected";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = ["" "" "" "" ""];
        states = {
          warning = 20;
          critical = 10;
        };
      };

      tray = {
        spacing = 10;
      };
    }];

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.8);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 5px;
        color: #6c7086;
      }

      #workspaces button.active {
        color: #89b4fa;
      }

      #clock, #battery, #network, #pulseaudio, #tray {
        padding: 0 10px;
      }
    '';
  };
} 