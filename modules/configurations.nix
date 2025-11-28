{
  config,
  lib,
  inputs,
  ...
}:
let
  classAspects = lib.types.lazyAttrsOf (
    lib.types.submodule {
      options = {
        module = lib.mkOption { type = lib.types.deferredModule; };
        use = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
      };
    }
  );
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
    homeManager = lib.mkOption { type = classAspects; };
    configurations.homeManager = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule {
          options = {
            system = lib.mkOption { type = lib.types.str; };
            module = lib.mkOption { type = lib.types.deferredModule; };
            use = lib.mkOption { type = lib.types.listOf lib.types.str; };
          };
        }
      );
    };

    nixos = lib.mkOption { type = classAspects; };
  };
  config = {
    flake.modules.homeManager = toFlakeModules "homeManager";
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

    flake.modules.nixos = toFlakeModules "nixos";
  };
}
