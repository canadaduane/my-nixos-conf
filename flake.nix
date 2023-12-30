{
  description = "My NixOS ❄ / MacOS 🍏 Configuration";

  inputs = {
    stable.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "stable";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "stable";

    hardware.url = "github:NixOS/nixos-hardware/master";

    hm.url = "github:nix-community/home-manager/release-23.11";
    hm.inputs.nixpkgs.follows = "stable";

    nur.url = "github:nix-community/nur/master";

    nix-index.url = "github:Mic92/nix-index-database";
    nix-index.inputs.nixpkgs.follows = "stable";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    vscode-extensions.inputs.nixpkgs.follows = "stable";

  };

  outputs =
    { self
    , stable
    , darwin
    , hm
    , hardware
    , nur
    , utils
    , vscode-extensions
    , fenix
    , ...
    } @ inputs:
    let
      inherit (utils.lib) mkFlake;
      inherit (stable.lib.filesystem) listFilesRecursive;
      inherit (stable.lib) listToAttrs hasSuffix removeSuffix removePrefix;

      nixosConfig = {
        system = "x86_64-linux";

        specialArgs = {
          inherit hardware;
        };

        modules = [
          hm.nixosModules.home-manager
          ./system/nixos
        ];
      };

      darwinConfig = {
        system = "aarch64-darwin";
        output = "darwinConfigurations";
        builder = darwin.lib.darwinSystem;

        modules = [
          hm.darwinModules.home-manager
          ./system/darwin
        ];
      };

      mkHosts = dir:
        let
          platform =
            if hasSuffix "darwin" dir
            then darwinConfig else nixosConfig;
        in
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
        nur.overlay
      ];

      hostDefaults = {
        channelName = "stable";
        modules = [ ./system ];

        extraArgs = {
          user = "duane";
          version = "23.11";
        };
      };

      hosts =
        (mkHosts ./hosts/nixos) //
        (mkHosts ./hosts/darwin);
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