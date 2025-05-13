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
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    
    # Development
    nodejs
    bun
    rustc
    rustup
    gcc
    go
    gh
    code-cursor
    neovim
    android-studio
    exercism
    (python3.withPackages (ps: with ps; [
      jupyter
      notebook
      ipykernel
      numpy
      pandas
      matplotlib
      pip
      virtualenv
    ]))
    
    # PHP Development
    php82
    php82Packages.composer
    mysql80
    apacheHttpd
    adminer  # Lightweight database management tool (alternative to phpMyAdmin)
    
    # Laravel Development
    sqlite  # Often used for testing in Laravel
    redis  # Used for caching and queue in Laravel
    php82Extensions.redis  # PHP Redis extension
    php82Extensions.sqlite3  # PHP SQLite extension
    php82Extensions.pdo_sqlite  # PHP PDO SQLite extension
    php82Extensions.pdo_mysql  # PHP PDO MySQL extension
    
    # CLI tools
    zoxide
    yazi
    btop
    killall
    
    # GUI Applications
    google-chrome
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
    dunst
    libnotify

    # Android development
    android-tools  # This provides adb, fastboot, etc.
    android-studio
    jdk17
    gradle
    
    # If using Wayland, these might help with compatibility
    qt6.qtwayland
    qt6.full
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

    # Android SDK related
    ANDROID_HOME = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_SDK_ROOT = "${config.home.homeDirectory}/Android/Sdk";
    ANDROID_AVD_HOME = "${config.home.homeDirectory}/.android/avd";
    
    # Additional Wayland/Graphics variables
    LIBGL_ALWAYS_SOFTWARE = "1";  # Try this if emulator has graphics issues
  };

  home.sessionPath = [
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
    "$HOME/.npm-global/bin"
  ];

  # Basic program enables - detailed configs are in modules/
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
