{ config, pkgs, ... }:

{
  home.username = "duane";
  home.homeDirectory = "/home/duane";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    htop
    git
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -l";
      config-os = "sudo nvim /etc/nixos/configuration.nix";
      update-os = "sudo nixos-rebuild switch";
      config = "nvim ~/.config/home-manager/home.nix";
      update = "home-manager switch";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  programs.git = {
    enable = true;

    userName  = "Duane Johnson";
    userEmail = "duane.johnson@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      scaling-factor = 2;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/shell/keybindings" = {
      toggle-overview = ["<Super>slash"];
    };
  };
}
