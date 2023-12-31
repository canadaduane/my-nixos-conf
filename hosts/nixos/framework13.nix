{ config, lib, hardware, user, ... }:

{
  imports = with hardware.nixosModules; [
    framework-11th-gen-intel
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # TODO: Obsidian uses insecure electron?
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-25.9.0"
  # ];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # File System
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/6ac36646-83ab-45c3-93f7-53250f7438ee";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/B625-166C";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/38b1462e-a3e7-46d0-b8e0-839aba5bf2cc"; }];

  # Boot
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
}
