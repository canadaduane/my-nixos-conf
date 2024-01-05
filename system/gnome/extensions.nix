{ pkgs, ... }:

let
  extensions = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    burn-my-windows
    custom-osd
    emoji-copy
    fullscreen-avoider
    fullscreen-hot-corner
    one-thing
    pano
    rounded-window-corners
    steal-my-focus-window

    # appindicator
    # dash-to-dock
    # gtk-title-bar
    # just-perfection
    # space-bar
    # user-themes
  ];
in

{
  # Install packages
  home.packages = extensions;

  # Enable extensions
  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false;
    enabled-extensions = (map (e: e.extensionUuid) extensions);
  };
}
