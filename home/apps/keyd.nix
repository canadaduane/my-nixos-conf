{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.apps.flameshot;

  ini = pkgs.formats.ini { };

  settings = {
    "*blackbox" = {

      "meta_mac.a" = "C-S-a";
      "meta_mac.c" = "C-S-c";
      "meta_mac.k" = "C-S-k";
      "meta_mac.v" = "C-S-v";
    };
  };
in

{
  options.d.apps.keyd = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."keyd/app.conf".source = ini.generate "app.conf" settings;
  };
}
