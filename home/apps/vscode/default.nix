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

    # Make VSCode settings.json writable--helpful for tinkering and quick temporary changes
    home.activation =
      let
        userFilePath = "${config.xdg.configHome}/Code/User/settings.json";
        userSettings = config.programs.vscode.userSettings;
        jsonSettings = pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings);
      in
      {
        removeExistingVSCodeSettings = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
          rm -rf "${userFilePath}"
        '';

        overwriteVSCodeSymlink =
          lib.hm.dag.entryAfter [ "linkGeneration" ] ''
            rm -rf "${userFilePath}"
            cat ${jsonSettings} | ${pkgs.jq}/bin/jq --monochrome-output > "${userFilePath}"
          '';
      };
  };
}
