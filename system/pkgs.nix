{ pkgs, config, ... }:

{
  # Install packages for both Linux & Mac OS
  environment.systemPackages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    celluloid # video player
    krita # graphic art
    lazpaint # image editor
    obsidian # notes
    shotcut # video editing
    blackbox-terminal # terminal

    # Chat apps
    fractal # matrix chat
    telegram-desktop # unfree chat (personal)
    slack # unfree chat (business)
    discord # creative/gamer chat

    # CLI tools
    bitwarden-cli # access secrets
    broot # summarize deep dirs
    cmake # C's cmake
    coreutils # GNU/Linux tools
    curl # network requests
    eza # better ls
    entr # run commands when files change 
    fd # quick find
    file # file info
    fzf # fuzzy search
    gcc # compiler
    git # version control
    gnumake # make
    htop # system resources
    lazygit # ncurses git
    lsof # unix file info
    nixpkgs-fmt # format .nix code
    ripgrep # fast text search
    sqlite # database
    unzip # uncompress
    wget # download files
    wl-clipboard # wayland copy/paste
  ];
}
