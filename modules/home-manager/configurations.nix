{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    configurations.homeManager =
      let
        moduleAndSystem = lib.types.submodule {
          options = {
            system = lib.mkOption { type = lib.types.str; };
            module = lib.mkOption { type = lib.types.deferredModule; };
          };
        };
      in
      lib.mkOption {
        type = lib.types.lazyAttrsOf moduleAndSystem;
      };
  };

  config = {
    flake.modules.configurations = lib.mapAttrs' (name: module: {
      name = "homeManager.${name}";
      value = module;
    }) config.configurations.homeManager;

    flake.homeConfigurations =
      let
        configurations = config.configurations.homeManager;
        mapToConfiguration =
          name: configuration:
          let
            inherit (config.configurations.homeManager."${name}") system module;
          in
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages."${system}";
            modules = [ module ];
          };
      in
      lib.mapAttrs mapToConfiguration configurations;
  };
}

