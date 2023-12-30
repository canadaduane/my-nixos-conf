{ pkgs, ... }:

{
  d.shell.aliases = {
    lg = "lazygit";
  };

  # https://github.com/jesseduffield/lazygit
  programs.lazygit = {
    enable = true;

    settings = {
      git.paging.colorArg = "always";
    };
  };
}
