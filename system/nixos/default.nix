{ pkgs, version, ... }:

{
  imports = [
    ./boot.nix
    ./docker.nix
    ./gnome
    ./hardware.nix
    ./network.nix
    ./keyd
    ./pkgs.nix
    ./sound.nix
    ./systemd.nix
    ./users.nix
  ];

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
}
