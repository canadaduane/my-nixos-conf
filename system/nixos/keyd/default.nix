{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [ keyd ];

  services.keyd.enable = true;

  environment.etc."keyd/default.conf".source = ./keyd.conf;
}
