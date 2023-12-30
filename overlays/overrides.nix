channels: final: prev: {
  __dontExport = true;

  # Use the latest version for the following packages
  inherit (channels.unstable)
    # NixOS
    nix-ld

    # Development
    vscode
    vscode-extensions

    # Apps
    obsidian
    zoom-us

    # Other
    nerdfonts
    ;
}
