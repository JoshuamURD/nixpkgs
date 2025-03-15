{config, ...}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    extraConfig = ''
      # Monitor configuration
      monitor = eDP-1,2048x1280@120,0x0,1

      # Start wallpaper
      exec-once = hyprpaper
      # Fallback wallpaper setting with swaybg
      exec-once = swaybg -i ${config.home.homeDirectory}/.config/wallpapers/default.png

      # Basic environment variables
      env = XCURSOR_SIZE,32
      env = QT_QPA_PLATFORM,wayland
      env = CLUTTER_BACKEND,wayland

      exec-once = hyprctl setcursor Bibata-Modern-Classic 32
      exec-once = waybar &
      # Input configuration
      input {
        kb_layout = us
        follow_mouse = 1
      }

      # General configuration
      general {
        gaps_in = 5
        gaps_out = 10
        layout = dwindle
      }

      # Decoration configuration
      decoration {
        rounding = 5
      }

      # Animation configuration
      animations {
        enabled = false
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
