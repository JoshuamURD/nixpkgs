{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  xdg.configFile."ghostty/config".text = ''
    # Theme and appearance
    background = #282c34
    foreground = #abb2bf
    font-family = "Iosevka Nerd Font"
    font-size = 14
    
    # Window settings
    window-padding-x = 10
    window-padding-y = 10
    window-theme = dark
    
    # Shell configuration
    command = ${pkgs.fish}/bin/fish
    
    # Cursor settings
    cursor-style = block
    cursor-style-blink = true
    
    # Mouse settings
    mouse-hide-while-typing = true
    
    # Key bindings
    keybind = super+shift+c=copy_to_clipboard
    keybind = super+shift+v=paste_from_clipboard
    keybind = super+t=new_tab
    keybind = super+w=close_surface
    keybind = super+n=new_window
  '';
} 