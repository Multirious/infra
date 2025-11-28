{
  config,
  lib,
  inputs,
  ...
}:
let
  classAspectsWith =
    module:
    lib.types.lazyAttrsOf (
      lib.types.submodule (
        lib.recursiveUpdate {
          options = {
            module = lib.mkOption { type = lib.types.deferredModule; };
            use = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
            };
          };
        } module
      )
    );
  classAspects = classAspectsWith { };
  useToImports =
    className: use:
    builtins.map (useAspectName: config.flake.modules."${className}"."${useAspectName}") use;
  toFlakeModules =
    className:
    lib.mapAttrs (aspectName: aspect: {
      imports = [ aspect.module ] ++ (useToImports className aspect.use);
    }) config."${className}";
in
{
  options = {
    nixos = lib.mkOption { type = classAspects; };
    homeManager = lib.mkOption { type = classAspects; };

    configurations.nixos = lib.mkOption {
      type = classAspects;
    };
    configurations.homeManager = lib.mkOption {
      type = classAspectsWith {
        options.system = lib.mkOption { type = lib.types.str; };
      };
    };

  };
  config = {
    flake.modules.nixos = toFlakeModules "nixos";
    flake.modules.homeManager = toFlakeModules "homeManager";

    flake.nixosConfigurations =
      let
        toNixosConfigurations =
          configurationName: configuration:
          inputs.nixpkgs.lib.nixosSystem {
            modules = [
              configuration.module
              { imports = useToImports "nixos" configuration.use; }
            ];
          };
      in
      lib.mapAttrs toNixosConfigurations config.configurations.nixos;
    flake.homeConfigurations =
      let
        toHomeManagerConfigurations =
          configurationName: configuration:
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages."${configuration.system}";
            modules = [
              configuration.module
              {
                imports = useToImports "homeManager" configuration.use;
              }
            ];
          };
      in
      lib.mapAttrs toHomeManagerConfigurations config.configurations.homeManager;
  };
}
