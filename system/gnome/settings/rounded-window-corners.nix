{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell/extensions/rounded-window-corners" = {
      skip-libadwaita-app = true;
      skip-libhandy-app = false;

      global-rounded-corner-settings = [
        (mkDictionaryEntry [
          "padding"
          (mkVariant [
            (mkDictionaryEntry [ "top" (mkVariant 1) ])
            (mkDictionaryEntry [ "left" (mkVariant 1) ])
            (mkDictionaryEntry [ "right" (mkVariant 1) ])
            (mkDictionaryEntry [ "bottom" (mkVariant 1) ])
          ])
        ])

        (mkDictionaryEntry [
          "keep_rounded_corners"
          (mkVariant [
            (mkDictionaryEntry [ "maximized" (mkVariant true) ])
            (mkDictionaryEntry [ "fullscreen" (mkVariant false) ])
          ])
        ])

        (mkDictionaryEntry [ "border_radius" (mkVariant 8) ])
        (mkDictionaryEntry [ "smoothing" (mkVariant 1) ])
        (mkDictionaryEntry [ "enabled" (mkVariant true) ])
      ];
    };
  };
}
