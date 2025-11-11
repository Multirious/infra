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
        useModules = lib.types.mkOptionType {
          name = "Use";
          description = ''
            A function that accepts a set of homeManager modules and returns a list of them.
            Acts as a shortcut instead of writing `imports = [ top.config.flake.modules.<class>.<aspect> ]`.
          '';
          merge = loc: defs: builtins.map (def: def.value) defs;
        };
        configurationModule = lib.types.submodule {
          options = {
            system = lib.mkOption { type = lib.types.str; };
            module = lib.mkOption { type = lib.types.deferredModule; };
            use = lib.mkOption { type = useModules; };
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
            listOfImports = builtins.map (eachUse: eachUse config.flake.modules.homeManager) use;
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
