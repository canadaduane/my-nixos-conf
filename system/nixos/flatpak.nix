{ pkgs, user, ... }:

{
  # Enable flatpak with flathub configured
  services.flatpak.enable = true;

  # Add flathub
  system.activationScripts = {
    flathub = ''
      /run/current-system/sw/bin/flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };
  
  # Give flathub access to custom fonts
  # home.activation = {
  #   flathub = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #     /run/current-system/sw/bin/flatpak --user override --filesystem=$HOME/.local/share/fonts
  #     /run/current-system/sw/bin/flatpak --user override --filesystem=$HOME/.icons
  #   '';
  # };

  
  # TODO: Why doesn't this work?
  # environment.etc = {
  #   "flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
  #     url = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  #     hash = "sha256-M3HdJQ5h2eFjNjAHP+/aFTzUQm9y9K+gwzc64uj+oDo=";
  #   };
  # };
}
