{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "joshuamURD";
    userEmail = "jmacmaster9@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      
      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
        autocrlf = "input";
      };
      
      color.ui = "auto";
      
      pull.rebase = false;
      
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      
      merge.conflictStyle = "diff3";
    };
    
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      df = "diff";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    
    # Sign commits if you use GPG
    # signing = {
    #   key = "YOUR_GPG_KEY_ID";
    #   signByDefault = true;
    # };
  };
} 