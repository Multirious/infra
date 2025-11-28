{ config, lib, ... }:
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
  useToImports = class: use: builtins.map (useAspectName: class."${useAspectName}".module) use;
  toFlakeModules =
    class:
    lib.mapAttrs (aspectName: aspect: {
      imports = [ aspect.module ] ++ (useToImports class aspect.use);
    }) class;
in
{
  options = {
    homeManager = lib.mkOption { type = classAspects; };
    # nixos = lib.mkOption { type = classModules "nixos"; };
  };
  config = {
    flake.modules.homeManager = toFlakeModules config.homeManager;
    # flake.modules.nixos = flakeModule "nixos";
  };
}
