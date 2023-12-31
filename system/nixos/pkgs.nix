{ pkgs, user, ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";

  # Install packages just for Linux
  environment.systemPackages = with pkgs; [
    # Apps
    blanket # background sounds
    eyedropper # color picker
    gnome-obfuscate # hide parts of images
    gnome.dconf-editor # gui settings
    gnome.gnome-tweaks # mess with gnome
    google-chrome # browser
    gparted # disk partitions
    video-trimmer # clip videos

    # Other
    binutils # linker, assembler, etc.
    metadata-cleaner # image metadata privacy
    newsflash # RSS reader
    polkit
  ];
}
