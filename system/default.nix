{ pkgs, ... }:

{
  imports = [
    ./hm.nix
    ./firefox.nix
    ./fonts.nix
    ./nix.nix
    ./pkgs.nix
  ];

  # Localization
  time.timeZone = "America/Denver";
}
