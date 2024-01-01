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

    home.packages = [
      (hiPrio (pkgs.runCommand "nvim.desktop-hide" { } ''
        mkdir -p "$out/share/applications"
        cat "${config.programs.neovim.finalPackage}/share/applications/nvim.desktop" > "$out/share/applications/nvim.desktop"
        echo "Hidden=1" >> "$out/share/applications/nvim.desktop"
      ''))
    ];
  };
}

# { config, lib, pkgs, ... }:
# {
#   environment.systemPackages = [
#     (lib.hiPrio (pkgs.runCommand "nvim.desktop-hide" { } ''
#       mkdir -p "$out/share/applications"
#       cat "${config.programs.neovim.finalPackage}/share/applications/nvim.desktop" > "$out/share/applications/nvim.desktop"
#       echo "Hidden=1" >> "$out/share/applications/nvim.desktop"
#     ''))
#   ];
# }
