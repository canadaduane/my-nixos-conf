# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./keyd.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # allowed-users = [ "@wheel" ];
  # trusted-users = [ "root" "@wheel" ];

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
  ];

  programs.zsh.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dejavu_fonts
      fira-code-nerdfont
      noto-fonts-emoji
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
