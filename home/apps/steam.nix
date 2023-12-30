{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.apps.steam;
in

{
  options.d.apps.steam = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ steam ];

    home.sessionVariables = {
      STEAM_FORCE_DESKTOPUI_SCALING = "2";
    };
  };
}
