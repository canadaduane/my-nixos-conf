{ pkgs, ... }:

let
  extensions = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    burn-my-windows
    custom-osd
    fullscreen-avoider
    fullscreen-hot-corner
    one-thing
    pano

    # appindicator
    # dash-to-dock
    # gtk-title-bar
    # hide-universal-access
    # rounded-window-corners
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
