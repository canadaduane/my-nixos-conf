{ pkgs, lib, ... }:

let
  # Custom shortcuts
  shortcuts = [
    {
      name = "Terminal";
      command = "${pkgs.blackbox-terminal}/bin/blackbox";
      binding = "<Super>Return";
    }
    {
      name = "Sleep";
      command = "${pkgs.systemd}/bin/systemctl suspend";
      binding = "<Control><Super>z";
    }
  ];

  customPrefix = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";

  customKeybindings = map
    (sh: "/${customPrefix}/${sh.name}/")
    shortcuts;

  customSettings = lib.listToAttrs (map
    (sh: { name = "${customPrefix}/${sh.name}"; value = sh; })
    shortcuts);
in

{
  dconf.settings = customSettings // {
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = [ "<Super>m" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = customKeybindings;
    };
  };
}
