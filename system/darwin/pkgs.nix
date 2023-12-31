{
  # Install packages just for Mac OS
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    casks = [
      "docker"
      "google-chrome"
      "karabiner-elements"
    ];

    taps = [
      "homebrew/cask-versions"
    ];
  };
}
