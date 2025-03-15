{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      margin-top = 0;
      margin-left = 0;
      margin-right = 0;
      spacing = 0;
      modules-left = ["hyprland/workspaces" "hyprland/window"];
      modules-center = ["clock"];
      modules-right = ["cpu" "memory" "pulseaudio" "network" "battery" "tray"];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
          "7" = "七";
          "8" = "八";
          "9" = "九";
          "10" = "十";
        };
        persistent-workspaces = {
          "*" = 5;
        };
        sort-by-number = true;
      };

      "hyprland/window" = {
        format = "  {}";
        max-length = 40;
        separate-outputs = true;
      };

      cpu = {
        format = "󰻠 {usage}%";
        interval = 1;
        on-click = "kitty -e btop";
      };

      memory = {
        format = "󰍛 {percentage}%";
        interval = 1;
        on-click = "kitty -e btop";
      };

      clock = {
        format = "󰥔  {:%H:%M}";
        format-alt = "󰃭  {:%Y-%m-%d}";
        tooltip = false;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟";
        format-icons = {
          default = ["󰕿" "󰖀" "󰕾"];
        };
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "󰤨  {signalStrength}%";
        format-ethernet = "󰈀  Connected";
        format-disconnected = "󰤭  Disconnected";
        tooltip-format = "{essid}";
        on-click = "nm-connection-editor";
      };

      battery = {
        format = "{icon}  {capacity}%";
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        format-charging = "󰂄  {capacity}%";
        states = {
          warning = 30;
          critical = 15;
        };
        interval = 10;
      };

      tray = {
        spacing = 8;
        icon-size = 14;
      };
    }];

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Iosevka Nerd Font", "Noto Sans CJK JP";
        font-size: 16px;
        font-weight: 600;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
        transition: all 0.3s ease;
      }

      tooltip {
        background: rgba(30, 30, 46, 0.7);
        border: 1px solid rgba(205, 214, 244, 0.1);
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
      }

      tooltip label {
        color: #cdd6f4;
        padding: 4px 12px;
      }

      #workspaces {
        margin: 4px 6px;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.05);
        padding: 0 6px;
        box-shadow: 0 0 4px rgba(0, 0, 0, 0.05);
      }

      #workspaces button {
        padding: 0 8px;
        margin: 4px;
        border-radius: 8px;
        color: rgba(205, 214, 244, 0.7);
        background: transparent;
        transition: all 0.3s ease;
      }

      #workspaces button.active {
        color: #cdd6f4;
        background: rgba(255, 255, 255, 0.1);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.1);
      }

      #workspaces button:hover {
        color: #cdd6f4;
        background: rgba(255, 255, 255, 0.1);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.1);
      }

      #window {
        margin: 4px 6px;
        padding: 2px 12px;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.05);
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray {
        margin: 4px 3px;
        padding: 2px 12px;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
        transition: all 0.3s ease;
      }

      #clock {
        margin: 4px 6px;
        padding: 2px 16px;
        font-weight: 600;
        background: rgba(255, 255, 255, 0.07);
        color: #cdd6f4;
      }

      #battery.warning {
        color: #f9e2af;
        background: rgba(249, 226, 175, 0.1);
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
        background: rgba(243, 139, 168, 0.1);
        animation: blink 0.8s ease-in-out infinite;
      }

      #cpu.warning,
      #memory.warning {
        color: #f9e2af;
        background: rgba(249, 226, 175, 0.1);
      }

      @keyframes blink {
        50% {
          background: rgba(243, 139, 168, 0.2);
        }
      }

      #network.disconnected,
      #pulseaudio.muted {
        color: #f38ba8;
        background: rgba(243, 139, 168, 0.1);
      }

      /* Hover effects */
      #cpu:hover,
      #memory:hover,
      #network:hover,
      #pulseaudio:hover,
      #battery:hover {
        background: rgba(255, 255, 255, 0.1);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.1);
      }
    '';
  };
} 