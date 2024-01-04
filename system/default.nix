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

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable firmware updates
    fwupd.enable = true;
  };

  programs = {
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };


  security.polkit.enable = true;

  # Save power on laptop battery
  powerManagement.enable = true;


  nixpkgs.hostPlatform = "x86_64-linux";
}
