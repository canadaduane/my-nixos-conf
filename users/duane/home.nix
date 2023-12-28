{ config, pkgs, ... }:

{
  home.username = "duane";
  home.homeDirectory = "/home/duane";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    celluloid # video player
    fractal # matrix chat
    lazpaint # image editor
    shotcut # video editing
    vscodium # code editor

    # CLI tools
    bitwarden-cli # access secrets
    broot # summarize deep dirs
    eza # better ls
    fzf # fuzzy search
    git # version control
    htop # system resources
    lazygit # ncurses git
  ];

  programs.home-manager.enable = true;

  services.flameshot = {
    enable = true;
  };
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      lg = "lazygit";
      config-os = "nvim ~/config/system/configuration.nix";
      update-os = "sudo nix-channel --update";
      apply-os = "sudo nixos-rebuild switch -I nixos-config=$HOME/config/system/configuration.nix";
      config = "nvim ~/config/users/duane/home.nix";
      update = "nix-channel --update";
      apply = "home-manager switch -f $HOME/config/users/duane/home.nix";
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
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = -0.55;
    };
    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };
    "org/gnome/shell/keybindings" = {
      toggle-overview = ["<Super>slash"];
      maximize = ["<Super>m"];
    };
  };
}
