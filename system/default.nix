{ pkgs, version, ... }:

{
  imports = [
    ./boot.nix
    ./docker.nix
    ./envfs.nix
    ./flatpak.nix
    ./firefox.nix
    ./fonts.nix
    ./gnome
    ./hardware.nix
    ./hm.nix
    ./keyd
    ./network.nix
    ./nix.nix
    ./pkgs.nix
    ./shells.nix
    ./sound.nix
    ./steam.nix
    ./systemd.nix
    ./users.nix
  ];

  # Localization
  time.timeZone = "America/Denver";

  system.stateVersion = version;

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.polkit.enable = true;

  programs.dconf.enable = true;

  # Save power on laptop battery
  powerManagement.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
