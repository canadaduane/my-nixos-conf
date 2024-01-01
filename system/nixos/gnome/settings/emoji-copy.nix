{ pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/shell/extensions/alphabetical-app-grid" = {
      folder-order-position = "end";
    };
  };
}
