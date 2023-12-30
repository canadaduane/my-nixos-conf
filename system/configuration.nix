# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./keyd.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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

  # Enable flatpak with flathub configured
  services.flatpak.enable = true;
  system.activationScripts = {
    flathub = ''
      /run/current-system/sw/bin/flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
  # environment.etc = {
  #   "flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
  #     url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  #     hash = "sha256-M3HdJQ5h2eFjNjAHP+/aFTzUQm9y9K+gwzc64uj+oDo=";
  #   };
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install Steam
  programs.steam.enable = true;
  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "2";
  };

  services.dbus.enable = true;

  xdg.portal.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.duane = {
    isNormalUser = true;
    description = "Duane";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      neovim
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    wl-clipboard
  ] ++ (with pkgs.gnomeExtensions; [
    burn-my-windows
    custom-osd
    fullscreen-avoider
    fullscreen-hot-corner
    one-thing
    pano
  ]);

  programs.zsh.enable = true;

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      alegreya
      alegreya-sans
      dejavu_fonts
      fira-code-nerdfont
      font-awesome
      hack-font
      inconsolata
      inter
      liberation_ttf
      merriweather
      merriweather-sans
      mplus-outline-fonts.githubRelease
      noto-fonts
      noto-fonts-emoji
      # playfair
      roboto
      roboto-slab
      rubik
      open-sans
    ];
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
      monospace = [ "FiraCode Nerd Font Mono" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };


  system.stateVersion = "23.11";

}
