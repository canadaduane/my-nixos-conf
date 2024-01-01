{ pkgs, lib, user, version, ... }:

let
  homePrefix =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in

{
  imports = [
    ./apps
    ./cli
    ./dev
    ./autostart.nix
  ];

  home = {
    username = user;
    homeDirectory = lib.mkForce "${homePrefix}/${user}";
    stateVersion = version;
  };

  xdg.enable = true;
  programs.ssh.enable = true;
  programs.htop.enable = true;
  programs.home-manager.enable = true;
  xsession.numlock.enable = pkgs.stdenv.isLinux;
}
