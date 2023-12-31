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
      maximize = [ "<Super>m" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = customKeybindings;
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ ];
      open-application-menu = [ ];
      screenshot = [ ];
      screenshot-window = [ ];
      show-screen-recording-ui = [ "<Shift>Print" ];
      show-screenshot-ui = [ "Print" ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
      toggle-application-view = [ ];
      toggle-message-tray = [ ];
      toggle-overview = [ ];
    };
  };
}
