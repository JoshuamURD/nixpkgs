{ config, pkgs, ... }:

{
  imports = [ ./modules ];  # This imports all modules through default.nix

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
    
    # GUI Applications
    firefox
    rofi
    
    # Media and Sound
    playerctl
    pavucontrol
    flameshot
    
    # System tray applications
    blueman
    networkmanagerapplet
  ];

  home.sessionVariables = {
    POLYBAR_CONFIG = "${config.home.homeDirectory}/.config/home-manager/polybar/config.ini";
    EDITOR = "nvim";
    TERMINAL = "ghostty";
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
  };

  # Basic program enables - detailed configs are in modules/
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # Keep home.file for any future dotfile management
  home.file = {};
}
