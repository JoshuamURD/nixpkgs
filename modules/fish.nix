{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fish
    fzf
    neofetch
  ];

  programs.fish = {
    enable = true;
    
    shellAliases = {
      # Navigation
      ".." = "z ..";
      "..." = "z ../..";
      "ll" = "ls -la";
      "la" = "ls -a";
      
      # Git shortcuts
      g = "git";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gst = "git status";
      
      # System
      sys = "systemctl";
      sysu = "systemctl --user";
      y = "yazi";
      ys = "yazi --search";

      # Home Manager
      hm = "home-manager";
      hms = "home-manager switch";
      e = "nvim .";
      
      # Editor
      v = "nvim";
      
      # Directory shortcuts
      dl = "cd ~/Downloads";
      docs = "cd ~/Documents";
      
      # Package management
      nix-shell = "nix-shell --run fish";
      
      # Custom tools
      update = "sudo nixos-rebuild switch";
      
      # Polybar restart
      pb-restart = "pkill polybar && polybar main &";
    };

    # Fish shell functions
    functions = {
      fish_greeting = ""; # Disable greeting
      
      mkcd = {
        description = "Create and cd into directory";
        body = "mkdir -p $argv[1] && cd $argv[1]";
      };
      
      gitignore = {
        description = "Download gitignore template";
        body = "curl -sL https://www.gitignore.io/api/$argv";
      };
    };

    # Shell initialization
    interactiveShellInit = ''
      # Set environment variables
      set -gx EDITOR nvim
      set -gx VISUAL nvim
      
      # Set GOPATH and add Go-related paths
      set -gx GOPATH $HOME/go
      set -gx PATH $GOPATH/bin $PATH   # Changed order to prioritize Go binaries

      # Debug info - uncomment to check paths
      echo "GOPATH: $GOPATH"
      echo "PATH: $PATH"

      # Vi mode
      fish_vi_key_bindings
      
      # Directory colors
      set -gx LSCOLORS gxfxcxdxbxegedabagacad

      zoxide init fish | source
      neofetch

    '';
  };
} 