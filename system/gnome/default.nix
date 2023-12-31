{ pkgs, lib, ... }:

{
  d.hm = [{
    imports = [
      ./settings
      ./extensions.nix
    ];
  }];

  # Systray
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  services.xserver = {
    # Enable the graphical windowing system
    enable = true;

    # Enable the Gnome Desktop Environment.
    desktopManager.gnome.enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };

  services.gnome = {
    games.enable = false;
    core-developer-tools.enable = false;
    gnome-remote-desktop.enable = false;
    gnome-keyring.enable = true;
  };

  programs = {
    gnome-terminal.enable = false;
    gnome-disks.enable = true;
    evince.enable = true; #           # Document viewer
    file-roller.enable = true; #      # Archive manager
    seahorse.enable = true; #         # Passwords and Keys
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gedit
    gnome-console
    gnome-photos
    gnome-tour
    gnome.gnome-characters
    gnome.gnome-logs
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-screenshot
    gnome.gnome-terminal
    gnome.totem
    gnome.yelp
  ];
}
