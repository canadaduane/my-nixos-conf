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
    "org/gnome/shell/extensions/custom-osd" = with lib.hm.gvariant; {
      alpha = 25.0;
      delay = 2500.0;
      monitors = "all";

      # text
      color = [ "0.9647" "0.9607" "0.9568" "1" ];
      font = "Cantarell 12";

      # gradient
      bg-effect = "gradient";
      gradient-direction = "vertical";
      bgcolor = [ "0.5686" "0.2549" "0.6745" "1" ]; # light purple
      bgcolor2 = [ "0.7529" "0.3803" "0.7960" "1" ]; # lighter purple

      # position & size
      horizontal = 48.0;
      vertical = -44.0;
      size = 20;

      # appearance
      border = false;
      bradius = 50.0; # round pill shape
      shadow = true;

      clock-osd = "";
      osd-all = [
        (mkDictionaryEntry [ "icon-all" true ])
        (mkDictionaryEntry [ "label-all" true ])
        (mkDictionaryEntry [ "level-all" true ])
        (mkDictionaryEntry [ "numeric-all" true ])
      ];
      osd-nolabel = [
        (mkDictionaryEntry [ "icon-nolabel" true ])
        (mkDictionaryEntry [ "numeric-nolabel" true ])
      ];
      osd-nolevel = [
        (mkDictionaryEntry [ "icon-nolevel" true ])
        (mkDictionaryEntry [ "numeric-nolevel" true ])
      ];
      rotate = false;
    };
  };
}