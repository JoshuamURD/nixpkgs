{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    
    config = {
      modifier = "Mod4";
      
      fonts = {
        names = [ "Iosevka" ];
        size = 10.0;
      };

      gaps = {
        inner = 10;
        outer = 5;
        top = 60;
      };

      window = {
        border = 2;
        titlebar = false;
        commands = [
          { command = "move to workspace number 2: web"; criteria = { class = "Firefox"; }; }
          { command = "move to workspace number 3: chat"; criteria = { class = "discord"; }; }
          { command = "floating enable"; criteria = { class = "pavucontrol"; }; }
          { command = "floating enable"; criteria = { class = "nm-connection-editor"; }; }
        ];
      };

      floating = {
        modifier = "Mod4";
      };

      keybindings = let
        modifier = "Mod4";
      in {
        "${modifier}+Return" = "exec ghostty";
        "${modifier}+d" = "exec rofi -show run";
        "${modifier}+b" = "exec firefox";
        "${modifier}+c" = "exec cursor";
        "${modifier}+Shift+q" = "kill";
        
        # Focus
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+semicolon" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        # Move
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Split
        "${modifier}+h" = "split h";
        "${modifier}+v" = "split v";

        # Layouts
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";

        # Floating
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+Shift+a" = "focus parent";

        # Workspaces with names
        "${modifier}+1" = "workspace number 1: term";
        "${modifier}+2" = "workspace number 2: web";
        "${modifier}+3" = "workspace number 3: chat";
        "${modifier}+4" = "workspace number 4: code";
        "${modifier}+5" = "workspace number 5: media";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        # Move to workspace with names
        "${modifier}+Shift+1" = "move container to workspace number 1: term";
        "${modifier}+Shift+2" = "move container to workspace number 2: web";
        "${modifier}+Shift+3" = "move container to workspace number 3: chat";
        "${modifier}+Shift+4" = "move container to workspace number 4: code";
        "${modifier}+Shift+5" = "move container to workspace number 5: media";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Reload/Restart/Exit
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Exit?' -B 'Yes' 'i3-msg exit'";
        
        # Resize mode
        "${modifier}+r" = "mode resize";

        # Media keys
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

        # Additional useful keybindings
        "${modifier}+x" = "exec --no-startup-id i3lock -c 000000";
        "${modifier}+Shift+s" = "exec --no-startup-id flameshot gui";
        "${modifier}+m" = "exec --no-startup-id pavucontrol";
        
        # Screen brightness controls
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";
        
        # Media player controls
        "XF86AudioPlay" = "exec --no-startup-id playerctl play-pause";
        "XF86AudioNext" = "exec --no-startup-id playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id playerctl previous";
      };

      modes = {
        resize = {
          "j" = "resize shrink width 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink height 10 px or 10 ppt";
          "semicolon" = "resize grow width 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Return" = "mode default";
          "Escape" = "mode default";
          "Mod4+r" = "mode default";
        };
      };

      startup = [
        { command = "dex --autostart --environment i3"; notification = false; }
        { command = "picom --config ~/.config/picom/picom.conf -b"; always = true; notification = false; }
        { command = "polybar main"; always = true; notification = false; }
        { command = "xss-lock --transfer-sleep-lock -- i3lock --nofork"; notification = false; }
        { command = "nm-applet"; notification = false; }
        { command = "dunst"; notification = false; }
        { command = "nitrogen --restore"; notification = false; }
        { command = "blueman-applet"; notification = false; }
      ];

      bars = [];  # Empty list to disable i3bar

      colors = {
        focused = {
          border = "#4c7899";
          background = "#285577";
          text = "#ffffff";
          indicator = "#2e9ef4";
          childBorder = "#285577";
        };
        focusedInactive = {
          border = "#333333";
          background = "#5f676a";
          text = "#ffffff";
          indicator = "#484e50";
          childBorder = "#5f676a";
        };
        unfocused = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
          indicator = "#292d2e";
          childBorder = "#222222";
        };
        urgent = {
          border = "#2f343a";
          background = "#900000";
          text = "#ffffff";
          indicator = "#900000";
          childBorder = "#900000";
        };
      };
    };
  };

  # Additional dependencies (i3-specific)
  home.packages = with pkgs; [
    dex
    picom
    xss-lock
    i3lock
    rofi
    alacritty
    firefox
  ];
} 