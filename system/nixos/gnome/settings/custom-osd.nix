{ lib, ... }:

{
  dconf.settings = {
    "org/gnome/shell/extensions/custom-osd" = with lib.hm.gvariant; {
      alpha = 25.0;
      delay = 2500.0;
      monitors = "all";

      # text
      color = [ "0.9647" "0.9607" "0.9568" "1" ];
      font = "Cantarell 12";

      # gradient
      bg-effect = "gradient";
      gradient-direction = "vertical";
      bgcolor = [ "0.5686" "0.2549" "0.6745" "1" ]; # light purple
      bgcolor2 = [ "0.7529" "0.3803" "0.7960" "1" ]; # lighter purple

      # position & size
      horizontal = 48.0;
      vertical = -44.0;
      size = 20;

      # appearance
      border = false;
      bradius = 50.0; # round pill shape
      shadow = true;

      clock-osd = "";
      osd-all = [
        (mkDictionaryEntry [ "icon-all" true ])
        (mkDictionaryEntry [ "label-all" true ])
        (mkDictionaryEntry [ "level-all" true ])
        (mkDictionaryEntry [ "numeric-all" true ])
      ];
      osd-nolabel = [
        (mkDictionaryEntry [ "icon-nolabel" true ])
        (mkDictionaryEntry [ "numeric-nolabel" true ])
      ];
      osd-nolevel = [
        (mkDictionaryEntry [ "icon-nolevel" true ])
        (mkDictionaryEntry [ "numeric-nolevel" true ])
      ];
      rotate = false;
    };
  };
}
