{ config, options, inputs, lib, version, user, ... }:

with lib;

let
  cfg = config.d.hm;
in

{
  options.d.hm = mkOption {
    type = types.listOf types.attrs;
    default = [ ];
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit version user;
      };

      users.${user} = {
        imports = cfg ++ [
          inputs.nix-index.hmModules.nix-index
          ../home
        ];
      };

      # BUG: scaling-factor can't be set on first boot due to missing gdm profile
      #      see https://github.com/nix-community/home-manager/issues/4352
      users.gdm = { lib, ... }: {
        home.stateVersion = version;
        dconf.settings = {
          "org/gnome/desktop/interface" = with lib.hm.gvariant; {
            scaling-factor = mkUint32 2;
          };
        };
      };

    };
  };
}
