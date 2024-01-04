{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [ keyd ];

  services.keyd.enable = true;

  environment.etc."keyd/default.conf".source = ./keyd.conf;

  environment.etc."libinput/local-overrides.quirks".text = ''
    [keyd]
    MatchUdevType=keyboard
    MatchVendor=0xFAC
    AttrKeyboardIntegration=internal
  '';
}
