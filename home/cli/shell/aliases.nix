{
  d.shell.aliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    clear = "tput reset";
    grep = "rg";
    mkdir = "mkdir -p";
    info = "npx info-cli";
  };

  # Linux
  d.shell.linux.aliases = {
    open = "xdg-open &> $HOME/.xdg-open.log";
    xargs = "xargs -r";
  };
}
