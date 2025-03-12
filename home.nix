{ config, pkgs, ... }:

{
  imports = [ ./modules/default.nix ];  # This imports all modules through default.nix

  home = {
    username = "joshuam";
    homeDirectory = "/home/joshuam";
    stateVersion = "24.11";
  };

  nixpkgs.config.allowUnfree = true;

  # User-specific packages that don't need special configuration
  home.packages = with pkgs; [
    # Fonts
    iosevka
    (nerdfonts.override { fonts = [ "Iosevka" "FiraCode" "JetBrainsMono" ]; })
    
    # Development
    nodejs
    bun
    rustc
    cargo
    gcc
    go
    gh
    code-cursor
    neovim
    
    # CLI tools
    zoxide
    yazi
    btop
    killall
    
    # GUI Applications
    firefox
    rofi-wayland
    
    # Media and Sound
    playerctl
    pavucontrol
    flameshot
    
    # System tray applications
    blueman
    networkmanagerapplet
    
    # Wayland specific
    waybar
    wl-clipboard
    grim
    slurp

    # Add these if not present
    hyprland
    xdg-desktop-portal-hyprland
  ];

  home.sessionVariables = {
    POLYBAR_CONFIG = "${config.home.homeDirectory}/.config/home-manager/polybar/config.ini";
    EDITOR = "nvim";
    TERMINAL = "ghostty";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    GOPATH = "${config.home.homeDirectory}/go";
    
    # Wayland specific
    NIXOS_OZONE_WL = "1";  # For Electron apps
    WLR_NO_HARDWARE_CURSORS = "1";  # If you have cursor issues
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # Basic program enables - detailed configs are in modules/
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
