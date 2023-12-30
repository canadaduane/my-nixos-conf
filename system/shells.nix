{ pkgs, ... }:

{
  environment = {
    shells = [ pkgs.bashInteractive pkgs.zsh ];
  };

  programs = {
    bash.enableCompletion = true;

    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
}
