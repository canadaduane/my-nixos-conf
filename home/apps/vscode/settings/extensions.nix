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

    # Shell Format
    "shellformat.useEditorConfig" = true;
    "shellformat.path" = "${pkgs.shfmt}/bin/shfmt";

    # Docker
    "[dockerfile]" = {
      "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
    };
  };
}
