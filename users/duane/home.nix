{ config, pkgs, lib, ... }:

let
  burnMyWindowsProfile = pkgs.writeText "nix-profile.conf" ''
    [burn-my-windows-profile]

    profile-high-priority=true
    profile-window-type=0
    profile-animation-type=0
    fire-enable-effect=false
    glide-enable-effect=true
    glide-animation-time=250
    glide-squish=0.0
    glide-tilt=0.0
    glide-shift=0.0
    glide-scale=0.85
  '';

  system = builtins.currentSystem;

  extensions =
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/nix-vscode-extensions";
      ref = "refs/heads/master";
      rev = "12ddf5e3ed4edf6ec5628fdb8dad8742cd162edf";
    })).extensions.${system};

  extensionsList = with extensions; [
    open-vsx.auiworks.amvim
    open-vsx.dbaeumer.vscode-eslint
    open-vsx.esbenp.prettier-vscode
    open-vsx.prisma.prisma
    open-vsx.reduckted.vscode-gitweblinks
    open-vsx.rust-lang.rust-analyzer
    open-vsx.stkb.rewrap
    vscode-marketplace.bierner.lit-html
    vscode-marketplace.jnoortheen.nix-ide
    vscode-marketplace.simonsiefke.svg-preview
  ];
in

{
  imports = [ ./firefox.nix ];

  home.username = "duane";
  home.homeDirectory = "/home/duane";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    celluloid # video player
    fractal # matrix chat
    krita # graphic art
    lazpaint # image editor
    shotcut # video editing

    # CLI tools
    bitwarden-cli # access secrets
    broot # summarize deep dirs
    eza # better ls
    fzf # fuzzy search
    git # version control
    htop # system resources
    lazygit # ncurses git
    nixpkgs-fmt # format .nix code
  ];

  xdg.configFile.kritarc.source = ./kritarc;

  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = extensionsList;
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

    userName = "Duane Johnson";
    userEmail = "duane.johnson@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  systemd.user.tmpfiles.rules = [
    # Set up `Burn My Windows` config, as it uses a separate file in $HOME/.config.
    "L+ %h/.config/burn-my-windows/profiles/nix-profile.conf 0755 - - - ${burnMyWindowsProfile}"
  ];

  # Give flathub access to custom fonts
  home.activation = {
    flathub = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      /run/current-system/sw/bin/flatpak --user override --filesystem=$HOME/.local/share/fonts
      /run/current-system/sw/bin/flatpak --user override --filesystem=$HOME/.icons
    '';
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      center-new-windows = true;
      workspaces-only-on-primary = true;
    };
    "org/gnome/shell".enabled-extensions = [
      "burn-my-windows@schneegans.github.com"
      "custom-osd@neuromorph"
      "fullscreen-avoider@noobsai.github.com"
      "fullscreen-hot-corner@sorrow.about.alice.pm.me"
      "one-thing@github.com"
      "pano@elhan.io"
    ];
    "org/gnome/shell/extensions/burn-my-windows" = {
      active-profile = "${burnMyWindowsProfile}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      scaling-factor = 2;
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "12h";
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
      toggle-overview = [ "<Super>slash" ];
      maximize = [ "<Super>m" ];
    };
  };
}
