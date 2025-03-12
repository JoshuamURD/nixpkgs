{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    extraConfig = ''
      # Monitor configuration
      monitor = eDP-1,2048x1280@120,auto,1

      # Basic environment variables
      env = XCURSOR_SIZE,24
      env = QT_QPA_PLATFORM,wayland
      env = SDL_VIDEODRIVER,wayland
      env = CLUTTER_BACKEND,wayland

      # Input configuration
      input {
        kb_layout = us
        follow_mouse = 1
        touchpad {
          natural_scroll = true
          tap-to-click = true
        }
      }

      # General configuration
      general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        layout = dwindle
      }

      # Decoration configuration
      decoration {
        rounding = 10
        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(00000055)

        blur {
          enabled = true
          size = 5
          passes = 2
          new_optimizations = true
        }

        active_opacity = 0.95
        inactive_opacity = 0.85
      }

      # Animation configuration
      animations {
        enabled = true
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

      # Window rules
      windowrule = float, ^(pavucontrol|blueman-manager|nm-connection-editor)$
      windowrule = center, ^(pavucontrol|blueman-manager|nm-connection-editor)$

      # Key bindings
      $mod = SUPER

      bind = $mod, RETURN, exec, ghostty
      bind = $mod, D, exec, rofi -show drun
      bind = $mod, Q, killactive
      bind = $mod, V, togglefloating
      bind = $mod, P, pseudo
      bind = $mod, J, togglesplit
      bind = $mod, F, fullscreen
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
} 
