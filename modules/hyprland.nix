{config, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    extraConfig = ''
      # Monitor configuration
      monitor = eDP-1,2048x1280@120,1920x0,1
      monitor = HDMI-A-1,preferred,3968x0,1
      monitor = DP-2,1920x1080@60,3968x0,1,transform,1

      # Lid switch behavior
      bindl = , switch:Lid Switch, exec, hyprctl keyword monitor "eDP-1, disable"
      bindl = , switch:off:Lid Switch, exec, hyprctl keyword monitor "eDP-1,2048x1280@120,1920x0,1"

      # AMD GPU optimizations
      env = WLR_DRM_NO_ATOMIC,1
      env = WLR_RENDERER_ALLOW_SOFTWARE,1
      env = XCURSOR_SIZE,32
      env = QT_QPA_PLATFORM,wayland
      env = CLUTTER_BACKEND,wayland

      # Start wallpaper
      exec-once = hyprpaper

      exec-once = hyprctl setcursor Bibata-Modern-Classic 32
      exec-once = waybar &
      exec-once = dunst &
      exec-once = ${config.home.homeDirectory}/.config/hypr/scripts/battery-monitor.sh &

      # Input configuration
      input {
        kb_layout = us
        follow_mouse = 1
        touchpad {
          natural_scroll = true
          disable_while_typing = true
          scroll_factor = 0.5
        }
      }

      # General configuration
      general {
        gaps_in = 5
        gaps_out = 10
        layout = dwindle
        border_size = 2
        allow_tearing = false
      }

      # Decoration configuration
      decoration {
        rounding = 8
        
        # Active/Inactive opacity
        active_opacity = 1.0
        inactive_opacity = 0.95
        
        # Dim
        dim_inactive = true
        dim_strength = 0.1
        
        # Blur - reduced for better performance
        blur {
          enabled = true
          size = 3
          passes = 1
          ignore_opacity = true
          new_optimizations = true
          xray = false
          noise = 0.0
          contrast = 0.9
          brightness = 0.9
          vibrancy = 0.0
          vibrancy_darkness = 0.0
          special = false
        }
      }

      # Animation configuration - optimized for performance
      animations {
        enabled = true
        
        # Simplified bezier curves
        bezier = wind, 0.1, 0.9, 0.1, 1.0
        
        # Reduced animation complexity
        animation = windows, 1, 4, wind
        animation = windowsIn, 1, 4, wind
        animation = windowsOut, 1, 4, wind
        animation = windowsMove, 1, 4, wind
        animation = fade, 1, 3, default
        animation = workspaces, 1, 4, wind
      }

      # Performance optimizations
      misc {
        vfr = true
        vrr = 1
        focus_on_activate = true
        animate_manual_resizes = false
        animate_mouse_windowdragging = false
        enable_swallow = false
        force_default_wallpaper = 0
      }

      # Window rules
      windowrulev2 = rounding 12, class:^(ghostty)$
      windowrulev2 = opacity 0.9 0.9, class:^(Cursor)$

      # Key bindings
      $mod = SUPER

      bind = $mod, T, exec, ghostty
      bind = $mod, F, exec, firefox
      bind = $mod, C, exec, cursor
      bind = $mod, D, exec, rofi -show drun
      bind = $mod, Q, killactive
      bind = $mod, V, togglefloating
      bind = $mod, P, pseudo
      bind = $mod, J, togglesplit
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d

      # Workspace bindings
      ${builtins.concatStringsSep "\n" (builtins.genList (x: ''
        bind = $mod, ${toString (x + 1)}, workspace, ${toString (x + 1)}
        bind = $mod SHIFT, ${toString (x + 1)}, movetoworkspace, ${toString (x + 1)}
      '') 9)}

      # Mouse bindings
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      # Media keys
      bind = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
      bind = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
      bind = , XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +10%
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-
    '';
  };

  home.file.".config/hypr/scripts/battery-monitor.sh" = {
    source = ./scripts/battery-monitor.sh;
    executable = true;
  };
} 
