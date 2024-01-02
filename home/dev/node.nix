{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.dev.node;

  lts-major = builtins.substring 0 2 pkgs.nodePackages.nodejs.version;
in

{
  options.d.dev.node = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bun
      corepack_20
      nodejs_20
      nodePackages.prettier
    ];
  };
}
