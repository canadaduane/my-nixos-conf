{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.d.apps.vscode;
in

{
  imports = [
    ./settings
    ./keybindings.nix
  ];

  options.d.apps.vscode = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    withCopilot = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = true;

      extensions = with pkgs; ([
        open-vsx.auiworks.amvim
        open-vsx.dbaeumer.vscode-eslint
        open-vsx.esbenp.prettier-vscode
        open-vsx.prisma.prisma
        open-vsx.reduckted.vscode-gitweblinks
        open-vsx.rust-lang.rust-analyzer
        open-vsx.stkb.rewrap
        vscode-marketplace.bierner.lit-html
        vscode-marketplace.jnoortheen.nix-ide
        vscode-marketplace.simonsiefke.svg-preview
      ]);
    };
  };
}
