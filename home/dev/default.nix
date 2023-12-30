{ pkgs, ... }:

{
  imports = [
    ./node.nix
    ./prisma.nix
    ./python.nix
    ./rust.nix
  ];

  # Globally installed dev tools
  home.packages = with pkgs; [
    nixpkgs-fmt
    shfmt
  ];
}
