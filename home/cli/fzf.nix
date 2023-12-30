{
  programs.fzf = rec {
    enable = true;

    defaultOptions = [
      "--layout=reverse"
      "--inline-info"
      "--height=50%"
    ];

    defaultCommand = "fd --type f --max-depth 10";
    changeDirWidgetCommand = "fd --type d --max-depth 10";
    fileWidgetCommand = defaultCommand;
  };
}
