{ pkgs, user, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users.users.${user}.extraGroups = [ "docker" ];
}
