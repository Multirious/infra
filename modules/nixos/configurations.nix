{
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    configurations.nixos =
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
      name = "nixos.${name}";
      value = module;
    }) config.configurations.nixos;

    flake.nixosConfigurations =
      let
        configurations = config.configurations.nixos;
        mapToSystem =
          name: configuration:
          let
            inherit (configuration) module use;
            listOfImports = builtins.map (eachUse: eachUse config.flake.modules.nixos) use;
            imports = lib.flatten listOfImports;
          in
          inputs.nixpkgs.lib.nixosSystem {
            modules = [
              module
              { inherit imports; }
            ];
          };
      in
      lib.mapAttrs mapToSystem configurations;
  };
}
