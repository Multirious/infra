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
        configurationModule = lib.types.submodule {
          options = {
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
            listOfImports = builtins.map (eachUse: config.flake.modules.nixos."${eachUse}") use;
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
