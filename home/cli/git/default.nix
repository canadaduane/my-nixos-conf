{ config, pkgs, user, ... }:

{
  imports = [
    ./delta.nix
    ./ui.nix
  ];

  home.packages = with pkgs; [
    git-ignore
  ];

  programs = {
    git = {
      enable = true;

      userName = "Duane Johnson";
      userEmail = "duane.johnson@gmail.com";

      extraConfig = {
        init.defaultBranch = "main";

        log = {
          decorate = true;
          abbrevCommit = true;
        };

        push.autoSetupRemote = true;
      };
    };
  };
}
