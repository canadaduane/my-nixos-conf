{ pkgs, ... }:

{
  # Fonts
  fonts = {
    enableDefaultPackages = true;

    fontDir.enable = true;

    packages = with pkgs; [
      alegreya
      alegreya-sans
      dejavu_fonts
      fira-code-nerdfont
      font-awesome
      hack-font
      inconsolata
      inter
      liberation_ttf
      merriweather
      merriweather-sans
      noto-fonts-emoji
      # playfair
      roboto
      roboto-slab
      rubik
      open-sans
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
        monospace = [ "FiraCode Nerd Font Mono" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

}
