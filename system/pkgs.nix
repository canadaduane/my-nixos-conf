{ pkgs, config, ... }:

{
  # Install packages for both Linux & Mac OS
  environment.systemPackages = with pkgs; [
    # Graphical apps
    amberol # music player
    bitwarden # passwords
    blackbox-terminal # terminal
    blanket # background sounds
    blender # 3d modeling & anim
    celluloid # video player
    dbeaver # database design
    eyedropper # color picker
    gnome-obfuscate # hide parts of images
    gnome.dconf-editor # gui settings
    gnome.gnome-tweaks # mess with gnome
    goldendict-ng # dictionary
    google-chrome # browser
    gparted # disk partitions
    inkscape # vector art
    krita # graphic art
    lazpaint # image editor
    metadata-cleaner # image metadata privacy
    newsflash # RSS reader
    obsidian # notes
    shotcut # video editing
    upscayl # image upscaler
    video-trimmer # clip videos
    xournalpp # PDF notes & signatures

    # Chat apps
    fractal # matrix chat
    telegram-desktop # unfree chat (personal)
    slack # unfree chat (business)
    discord # unfree chat (creative/gamer)

    # Dev tools 
    binutils # linker, assembler, etc.
    cmake # C's cmake
    gcc # compiler
    gnumake # make
    podman # containers
    podman-desktop # container GUI 

    # CLI tools
    broot # summarize deep dirs
    coreutils # GNU/Linux tools
    curl # network requests
    eza # better ls
    entr # run commands when files change 
    fd # quick find
    file # file info
    fzf # fuzzy search
    git # version control
    httpie # API testing
    lazygit # ncurses git
    lsof # unix file info
    nixpkgs-fmt # format .nix code
    polkit # coordinate app permissions
    ripgrep # fast text search
    sqlite # database
    unzip # uncompress
    wget # download files
    wl-clipboard # wayland copy/paste
  ];

}
