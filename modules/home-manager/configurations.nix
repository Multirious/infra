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
        configurationModule = lib.types.submodule {
          options = {
            system = lib.mkOption { type = lib.types.str; };
            module = lib.mkOption { type = lib.types.deferredModule; };
            use = lib.mkOption { type = lib.types.listOf lib.types.str; };
          };
        };
      in
      lib.mkOption {
        type = lib.types.lazyAttrsOf configurationModule;
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
            inherit (configuration) system module use;
            listOfImports = builtins.map (eachUse: config.flake.modules.homeManager."${eachUse}") use;
            imports = lib.flatten listOfImports;
          in
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages."${system}";
            modules = [
              module
              { inherit imports; }
            ];
          };
      in
      lib.mapAttrs mapToConfiguration configurations;
  };
}
