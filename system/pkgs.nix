{ pkgs, config, ... }:

{
  # Install packages for both Linux & Mac OS
  environment.systemPackages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    blackbox-terminal # terminal
    blender # 3d modeling & anim
    celluloid # video player
    dbeaver # database design
    goldendict-ng # dictionary
    inkscape # vector art
    krita # graphic art
    lazpaint # image editor
    obsidian # notes
    podman # containers
    podman-desktop # container GUI 
    shotcut # video editing
    upscayl # image upscaler

    # Chat apps
    fractal # matrix chat
    telegram-desktop # unfree chat (personal)
    slack # unfree chat (business)
    discord # unfree chat (creative/gamer)

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
    httpie # API testing
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
