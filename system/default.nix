{ pkgs, ... }:

{
  imports = [
    ./hm.nix
    ./firefox.nix
    ./fonts.nix
    ./nix.nix
    ./pkgs.nix
    ./shells.nix
  ];

  # Localization
  time.timeZone = "America/Denver";
}
