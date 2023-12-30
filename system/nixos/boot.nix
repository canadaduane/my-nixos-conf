{ lib, ... }:

{
  boot = {
    loader = {
      timeout = 1;

      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}
