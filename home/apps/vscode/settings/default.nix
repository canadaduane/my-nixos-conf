{ pkgs, ... }:

{
  imports = [
    ./extensions.nix
  ];

  programs.vscode.userSettings = {
    # Editor
    "files.enableTrash" = true;
    "files.autoSave" = "off";
    "editor.cursorSmoothCaretAnimation" = "on";
    "editor.cursorStyle" = "line";
    "editor.emptySelectionClipboard" = false;
    "editor.fontFamily" = "'FiraCode Nerd Font'";
    "editor.fontSize" = 13;
    "editor.formatOnSave" = true;
    "editor.inlineSuggest.enabled" = true;

    # Workbench
    "workbench.startupEditor" = "none";
    "workbench.welcomePage.walkthroughs.openOnInstall" = false;
    "workbench.tree.indent" = 16;

    # Security
    "security.workspace.trust.enabled" = false;

    # Explorer
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;

    # Terminal
    "terminal.integrated.fontSize" = 13;

    # Git
    "git.autofetch" = false;
    "git.autoStash" = true;
    "git.pullTags" = true;
    "git.enableCommitSigning" = true;
    "git.alwaysSignOff" = false;
    "git.suggestSmartCommit" = false;
    "git.confirmSync" = false;
    "git.openRepositoryInParentFolders" = "always";

    # Extensions
    "extensions.ignoreRecommendations" = true;

    # Other
    "search.showLineNumbers" = false;
    "debug.console.fontSize" = 13;
    "window.menuBarVisibility" = "hidden";
  };
}
