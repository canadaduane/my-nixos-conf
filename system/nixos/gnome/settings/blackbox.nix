{ lib, ... }:

{
  dconf.settings = {
    "com/raggesilver/BlackBox" = with lib.hm.gvariant; {
      fill-tabs = false;
      floating-controls = true;
      floating-controls-hover-area = (mkUint32 10);
      delay-before-showing-floating-controls = (mkUint32 300);
      font = "FiraCode Nerd Font 12";
      headerbar-drag-area = true;
      notify-process-completion = false;
      opacity = mkUint32 85;
      pretty = true;
      remember-window-size = true;
      show-headerbar = true;
      show-menu-button = true;
      terminal-bell = false;
      terminal-padding = (mkTuple [
        (mkUint32 6)
        (mkUint32 6)
        (mkUint32 6)
        (mkUint32 6)
      ]);
      theme-dark = "Adwaita Dark";
    };
  };
}
