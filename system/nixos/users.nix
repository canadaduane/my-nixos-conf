{ user, ... }:

{
  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = [ "wheel" ];
    useDefaultShell = true;
  };

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
  '';
}
