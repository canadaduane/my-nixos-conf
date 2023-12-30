{ pkgs
, lib
, ...
}:

let
  keydConfig = builtins.readFile ./keyd.conf;
in

{
  environment.systemPackages = [
    pkgs.keyd
  ];

  # users.groups.keyd = { };

  services.keyd = {
    enable = true;
  };

  environment.etc."keyd/default.conf".text = keydConfig;
}
