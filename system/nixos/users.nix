{ user, ... }:

let
  passDir = "/nix/data/passwords";
in

{
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = [ "wheel" ];
  };

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
  '';
}
