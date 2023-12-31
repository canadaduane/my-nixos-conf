{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.apps.obs;
in

{
  options.d.apps.obs = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.obs-studio.enable = true;
  };
}
