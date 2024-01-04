{ pkgs, ... }:

let
  prettier = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
in

{
  programs.vscode.userSettings = {
    ## Prettier
    "prettier.enable" = true;
    "prettier.semi" = true;

    "[css]" = prettier;
    "[scss]" = prettier;
    "[html]" = prettier;
    "[json]" = prettier;
    "[jsonc]" = prettier;
    "[markdown]" = prettier;
    "[javascript]" = prettier;
    "[typescript]" = prettier;
    "[javascriptreact]" = prettier;
    "[typescriptreact]" = prettier;

    # Nix IDE
    "nix.formatterPath" = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";

    # AmVim
    "amVim.bindCtrlCommands" = false;
  };
}
