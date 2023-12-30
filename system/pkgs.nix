{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    celluloid # video player
    fractal # matrix chat
    krita # graphic art
    lazpaint # image editor
    shotcut # video editing

    # CLI tools
    bitwarden-cli # access secrets
    broot # summarize deep dirs
    cmake
    coreutils
    curl
    eza # better ls
    fd
    file
    fzf # fuzzy search
    gcc
    git # version control
    gnumake
    htop # system resources
    lazygit # ncurses git
    lsof
    nixpkgs-fmt # format .nix code
    ripgrep
    sqlite
    unzip
    wget
    wl-clipboard

    # Investigate
    #  entr
    #  helix
    #  wezterm
    #  httpie
    #  killall
    #  neofetch
  ];
}
