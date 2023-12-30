{ pkgs, version, ... }:

{
  imports = [
    ./gnome
    ./boot.nix
    ./docker.nix
    ./hardware.nix
    ./network.nix
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

  users.defaultUserShell = pkgs.zsh;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.polkit.enable = true;

  programs.dconf.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
