{ pkgs, user, ... }:

{
  # Enable flatpak with flathub configured
  services.flatpak = {
    enable = true;
    remotes = {
      flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      flathub-beta = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
  };

  # Give flathub access to custom fonts
  # home.activation = {
  #   flathub = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #     /run/current-system/sw/bin/flatpak --user override --filesystem=$HOME/.local/share/fonts
  #     /run/current-system/sw/bin/flatpak --user override --filesystem=$HOME/.icons
  #   '';
  # };
}
