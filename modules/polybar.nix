{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (polybar.override {
      i3Support = true;
      pulseSupport = true;
    })
    font-awesome
    material-design-icons
  ];
   services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    script = "polybar main &"; # Start the main bar

    # Basic config structure
    settings = {
      # Colors module - for easy maintenance and reuse
      "colors" = {
        background = "#11111b";
        background-alt = "#1e1e2e";
        foreground = "#cdd6f4";
        primary = "#f5c2e7";     # Pink
        secondary = "#89dceb";   # Sky blue
        alert = "#f38ba8";      # Red
        disabled = "#45475a";
        accent = "#89b4fa";     # Blue
        purple = "#cba6f7";
        green = "#a6e3a1";
        pink = "#f5c2e7";
        cyan = "#94e2d5";
        orange = "#fab387";
        yellow = "#f9e2af";
      };

      # Main bar configuration
      "bar/main" = {
        width = "85%";
        height = "32pt";
        radius = 12;
        offset-x = "7.5%";
        offset-y = "8px";

        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        fixed-center = true;

        line-size = "2pt";
        border-size = "0px";
        
        padding-left = 12;
        padding-right = 12;
        
        module-margin-left = 1;
        module-margin-right = 1;

        font-0 = "JetBrainsMono Nerd Font:style=Regular:size=11;3";
        font-1 = "JetBrainsMono Nerd Font:style=Bold:size=11;3";
        font-2 = "JetBrainsMono Nerd Font:size=14;4";
        font-3 = "Material Icons:style=Regular:size=13;4";

        modules-left = "i3 xwindow";
        modules-center = "date";
        modules-right = "pulseaudio memory cpu wlan battery";

        enable-ipc = true;
        tray-position = "none";

        override-redirect = true;
        wm-restack = "i3";
      };

      # Add dedicated tray module
      "module/tray" = {
        type = "internal/tray";
        tray-spacing = 5;
        tray-padding = 2;
        tray-background = "\${colors.background-alt}";
      };

      # Modules configuration
      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        show-urgent = true;
        strip-wsnumbers = true;
        index-sort = true;
        enable-click = true;
        enable-scroll = false;
        wrapping-scroll = false;
        reverse-scroll = false;
        fuzzy-match = true;
        
        ws-icon-0 = "1;󰎤";
        ws-icon-1 = "2;󰎧";
        ws-icon-2 = "3;󰎪";
        ws-icon-3 = "4;󰎭";
        ws-icon-4 = "5;󰎱";
        ws-icon-5 = "6;󰎳";
        ws-icon-6 = "7;󰎶";
        ws-icon-7 = "8;󰎹";
        ws-icon-8 = "9;󰎼";
        ws-icon-default = "󰎡";
        
        format = "<label-state> <label-mode>";
        
        label-mode = "%mode%";
        label-mode-padding = 2;
        label-mode-background = "\${colors.alert}";
        
        label-focused = "%icon% %name%";
        label-focused-foreground = "\${colors.primary}";
        label-focused-background = "\${colors.background-alt}";
        label-focused-underline = "\${colors.primary}";
        label-focused-padding = 2;
        
        label-unfocused = "%icon% %name%";
        label-unfocused-padding = 2;
        label-unfocused-background = "\${colors.background}";
        label-unfocused-foreground = "\${colors.disabled}";
        
        label-visible = "%icon% %name%";
        label-visible-padding = 2;
        label-visible-background = "\${colors.background-alt}";
        label-visible-underline = "\${colors.disabled}";
        
        label-urgent = "%icon% %name%";
        label-urgent-foreground = "\${colors.background}";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 2;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:60:...%";
        label-background = "\${colors.background-alt}";
        label-padding = 2;
        format-prefix = " ";
        format-prefix-foreground = "\${colors.cyan}";
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";
        interval = 30;
        warn-percentage = 75;

        format-mounted = "<label-mounted>";
        format-mounted-prefix = "󰋊 ";
        format-mounted-prefix-foreground = "\${colors.cyan}";
        format-mounted-background = "\${colors.background-alt}";
        format-mounted-padding = 2;
        label-mounted = "%mountpoint% %percentage_used%%";
        label-unmounted = "%mountpoint% not mounted";
        label-unmounted-foreground = "\${colors.disabled}";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "󰍛 ";
        format-prefix-foreground = "\${colors.purple}";
        format-background = "\${colors.background-alt}";
        format-padding = 2;
        label = "%percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "󰻠 ";
        format-prefix-foreground = "\${colors.orange}";
        format-background = "\${colors.background-alt}";
        format-padding = 2;
        label = "%percentage:2%%";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "ACAD";
        full-at = 98;

        format-charging = "<animation-charging> <label-charging>";
        format-charging-background = "\${colors.background-alt}";
        format-charging-padding = 2;
        
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-background = "\${colors.background-alt}";
        format-discharging-padding = 2;
        
        format-full-background = "\${colors.background-alt}";
        format-full-padding = 2;
        
        format-full = "<label-full>";
        format-full-prefix = "󰁹 ";
        format-full-prefix-foreground = "\${colors.primary}";
        label-full = "%percentage%%";

        ramp-capacity-0 = "󰂎";
        ramp-capacity-1 = "󰁻";
        ramp-capacity-2 = "󰁽";
        ramp-capacity-3 = "󰂁";
        ramp-capacity-4 = "󰁹";
        ramp-capacity-foreground = "\${colors.green}";

        animation-charging-0 = "󰢜";
        animation-charging-1 = "󰂆";
        animation-charging-2 = "󰂇";
        animation-charging-3 = "󰂈";
        animation-charging-4 = "󰢝";
        animation-charging-foreground = "\${colors.primary}";
        animation-charging-framerate = 750;
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;

        date = "";
        date-alt = " %Y-%m-%d";
        time = "%H:%M";
        time-alt = "%H:%M:%S";

        format = "<label>";
        format-prefix = "󰥔 ";
        format-prefix-foreground = "\${colors.purple}";
        format-background = "\${colors.background-alt}";
        format-padding = 2;
        label = "%date% %time%";
        label-foreground = "\${colors.foreground}";
      };

      "module/wlan" = {
        type = "internal/network";
        interface-type = "wireless";
        interval = 3;
        
        format-connected = "<ramp-signal> <label-connected>";
        format-connected-foreground = "\${colors.green}";
        format-connected-background = "\${colors.background-alt}";
        format-connected-padding = 2;
        label-connected = "%essid%";
        
        format-disconnected = "<label-disconnected>";
        format-disconnected-background = "\${colors.background-alt}";
        format-disconnected-padding = 2;
        label-disconnected = "󰤮";
        label-disconnected-foreground = "\${colors.alert}";
        
        ramp-signal-0 = "󰤯";
        ramp-signal-1 = "󰤟";
        ramp-signal-2 = "󰤢";
        ramp-signal-3 = "󰤥";
        ramp-signal-4 = "󰤨";
        ramp-signal-foreground = "\${colors.cyan}";
      };

      "module/eth" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 3;
        
        format-connected-prefix = "󰈀 ";
        format-connected-prefix-foreground = "\${colors.green}";
        format-connected-background = "\${colors.background-alt}";
        format-connected-padding = 2;
        label-connected = "Connected";
        
        format-disconnected = "<label-disconnected>";
        format-disconnected-background = "\${colors.background-alt}";
        format-disconnected-padding = 2;
        label-disconnected = "󰈂";
        label-disconnected-foreground = "\${colors.alert}";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume-prefix = "󰕾 ";
        format-volume-prefix-foreground = "\${colors.secondary}";
        format-volume-background = "\${colors.background-alt}";
        format-volume-padding = 2;
        format-volume = "<label-volume>";
        label-volume = "%percentage%%";
        label-muted = "muted";
        label-muted-foreground = "\${colors.disabled}";
        format-muted-prefix = "󰖁 ";
        format-muted-background = "\${colors.background-alt}";
        format-muted-padding = 2;
      };
    };
  };
} 