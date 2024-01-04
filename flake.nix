{
  description = "My NixOS Configuration";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    declarative-flatpak.url = "github:GermanBread/declarative-flatpak/stable";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "stable";

    hardware.url = "github:NixOS/nixos-hardware/master";

    hm.url = "github:nix-community/home-manager/release-23.11";
    hm.inputs.nixpkgs.follows = "stable";

    nix-index.url = "github:Mic92/nix-index-database";
    nix-index.inputs.nixpkgs.follows = "stable";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vscode-extensions.inputs.nixpkgs.follows = "stable";
  };

  outputs =
    { self
    , stable
    , declarative-flatpak
    , hm
    , hardware
    , utils
    , vscode-extensions
    , fenix
    , ...
    } @ inputs:
    let
      inherit (utils.lib) mkFlake;
      inherit (stable.lib.filesystem) listFilesRecursive;
      inherit (stable.lib) listToAttrs hasSuffix removeSuffix removePrefix;

      platform = {
        system = "x86_64-linux";

        specialArgs = {
          inherit hardware;
        };

        modules = [
          hm.nixosModules.home-manager
          declarative-flatpak.nixosModules.default
        ];
      };

      mkHosts = dir:
        listToAttrs (map
          (host:
            {
              name = removeSuffix ".nix" (baseNameOf host);
              value = platform // {
                modules = platform.modules ++ [ host ];
              };
            }
          )
          (listFilesRecursive dir));

    in

    mkFlake {
      inherit self inputs;

      channelsConfig = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };

      channels = {
        stable = {
          overlaysBuilder = channels:
            map (o: (import o channels))
              (listFilesRecursive ./overlays);
        };
        unstable = { };
      };

      sharedOverlays = [
        vscode-extensions.overlays.default
        fenix.overlays.default
      ];

      hostDefaults = {
        channelName = "stable";
        modules = [ ./system ];

        extraArgs = {
          user = "duane";
          version = "23.11";
        };
      };

      hosts = (mkHosts ./hosts/nixos);
    };

  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
