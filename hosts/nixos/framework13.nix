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
      device = "/dev/disk/by-uuid/53abc4b3-9b27-4139-a5e3-bfa6a63f6d4b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/FCFA-0F79";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/8b95977b-8c63-4ec2-83bf-9b646a599f37"; }];

  # Boot
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
}
