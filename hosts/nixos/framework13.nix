{ config, lib, hardware, user, ... }:

{
  imports = [
    # https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/11th-gen-intel
    hardware.nixosModules.framework-11th-gen-intel

    # Specific hardware of the machine, including partition IDs
    ./hardware-configuration.nix
  ];
}
