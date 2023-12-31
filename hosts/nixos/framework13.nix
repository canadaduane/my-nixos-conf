{ config, lib, hardware, user, ... }:

{
  imports = [
    hardware.nixosModules.framework-11th-gen-intel
    ./hardware-configuration.nix
  ];
}
