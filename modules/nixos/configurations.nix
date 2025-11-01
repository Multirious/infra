{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    configurations.nixos = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule {
          options = {
            module = lib.mkOption { type = lib.types.deferredModule; };
          };
        }
      );
    };
  };

  config = {
    flake.modules.configurations = lib.mapAttrs' (name: module: {
      name = "nixos.${name}";
      value = module;
    }) config.configurations.nixos;

    flake.nixosConfigurations =
      let
        configurations = config.configurations.nixos;
        mapToSystem =
          name: configuration: inputs.nixpkgs.lib.nixosSystem { modules = [ configuration.module ]; };
      in
      lib.mapAttrs mapToSystem configurations;
  };
}
