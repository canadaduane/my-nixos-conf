channels: final: prev:

{
  __dontExport = true;

  # See https://discourse.nixos.org/t/krita-on-gnome-how-to-limit-multiple-desktop-files/37587
  krita = prev.krita.overrideAttrs ({ patches ? [ ], ... }: {
    patches = patches ++ [ ../patches/krita-sane-desktops.patch ];
  });
}
