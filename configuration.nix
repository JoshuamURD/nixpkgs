# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [ ];  # We can leave this empty since hardware-configuration.nix is handled in the flake

  # System-level configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Display server and window manager
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  # Locale and time
  time.timeZone = "Australia/Perth";
  i18n = {
    defaultLocale = "en_AU.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # System services
  services = {
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  # Default shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # User configuration
  users.users.joshuam = {
    isNormalUser = true;
    description = "Joshua Macmaster";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # System utilities
    powertop
    brightnessctl
    vim
    
    # Window manager components
    i3
    i3status
    i3lock
    dmenu
    polybarFull
    picom
    dunst
    nitrogen
    
    # System fonts
    font-awesome
  ];

  # Font configuration
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";
}
