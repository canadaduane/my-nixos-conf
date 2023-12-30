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

  # Bootloader
  # boot.loader = {
  #   systemd-boot = {
  #     enable = true;
  #     configurationLimit = 10;
  #   };
  #   efi = {
  #     canTouchEfiVariables = true;
  #   };
  # };

  # Enable networking
  # networking = {
  #   hostName = "nixos";
  #   networkmanager.enable = true;
  # };

  # Set your time zone.

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "en_US.UTF-8";
  #   LC_IDENTIFICATION = "en_US.UTF-8";
  #   LC_MEASUREMENT = "en_US.UTF-8";
  #   LC_MONETARY = "en_US.UTF-8";
  #   LC_NAME = "en_US.UTF-8";
  #   LC_NUMERIC = "en_US.UTF-8";
  #   LC_PAPER = "en_US.UTF-8";
  #   LC_TELEPHONE = "en_US.UTF-8";
  #   LC_TIME = "en_US.UTF-8";
  # };




  # services.printing.enable = true;

  # Install Steam

  # xdg.portal.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.duane = {
  #   isNormalUser = true;
  #   description = "Duane";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #     firefox
  #     neovim
  #   ];
  #   shell = pkgs.zsh;
  # };

  # nixpkgs.config.allowUnfree = true;

  # environment.systemPackages = with pkgs; [
  #   wget
  #   wl-clipboard
  # ] ++ (with pkgs.gnomeExtensions; [
  # ]);

  # programs.zsh.enable = true;

  # fonts = {
  #   enableDefaultPackages = true;
  #   fontDir.enable = true;
  #   packages = with pkgs; [
  #     alegreya
  #     alegreya-sans
  #     dejavu_fonts
  #     fira-code-nerdfont
  #     font-awesome
  #     hack-font
  #     inconsolata
  #     inter
  #     liberation_ttf
  #     merriweather
  #     merriweather-sans
  #     mplus-outline-fonts.githubRelease
  #     noto-fonts
  #     noto-fonts-emoji
  #     # playfair
  #     roboto
  #     roboto-slab
  #     rubik
  #     open-sans
  #   ];
  # };

  # fonts.fontconfig = {
  #   enable = true;
  #   defaultFonts = {
  #     sansSerif = [ "DejaVu Sans" ];
  #     serif = [ "DejaVu Serif" ];
  #     monospace = [ "FiraCode Nerd Font Mono" "Noto Color Emoji" ];
  #     emoji = [ "Noto Color Emoji" ];
  #   };
  # };


  # system.stateVersion = "23.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
