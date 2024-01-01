{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.apps.syncthing;
in

{
  options = {
    d.apps.syncthing = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      # extraOptions = [
      #   "--gui-apikey=abc123"
      # ];
    };
  };

}
