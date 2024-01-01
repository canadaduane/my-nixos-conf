{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.dev.neovim;
in

{
  options.d.dev.neovim = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
