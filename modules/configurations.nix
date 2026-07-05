{
  config,
  lib,
  inputs,
  ...
}:
let
  classAspectsWith =
    module:
    let
      inherit (lib) types mkOption;
    in
    types.lazyAttrsOf (
      types.submodule (
        lib.recursiveUpdate {
          options = {
            module = mkOption { type = types.deferredModule; };
            use = lib.mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
          };
        } module
      )
    );
  classAspects = classAspectsWith { };
  useToImports =
    className: use: use |> map (useAspectName: config.flake.modules."${className}"."${useAspectName}");
  toFlakeModules =
    className:
    config."${className}"
    |> lib.mapAttrs (
      aspectName: aspect: {
        imports = [ aspect.module ] ++ (useToImports className aspect.use);
      }
    );
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
