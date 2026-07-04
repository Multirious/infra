top: {
  configurations.homeManager.peach.use = [ "scripts" ];

  homeManager.scripts.module =
    { config, pkgs, lib, ... }:
    {
      options = {
        me.scripts = with lib.types; lib.mkOption {
          type = attrsOf (submodule {
            options = {
              text = lib.mkOption { type = str; };
              source = lib.mkOption { type = package; };
            };
          });
        }
      };
      config = {
        me.scripts = {}
        home.packages = lib.attrValues (lib.mapAttrs (
          scriptName: module: writeTextFile {
            name = scriptName;
            text = if module.text != null
              then module.text
              else builtins.readFile module.source;
            executable = true;
            destination = "/bin/${scriptName}";
          }
        ) config.me.scripts)
      };

      home.file = {
        "scripts/debug-derivative" = {
          executable = true;
          source = ./scripts/debug-derivative;
        };
        "scripts/clipboard-react-emote" = {
          executable = true;
          source = ./scripts/clipboard-react-emote;
        };
        "scripts/video-to-gif" = {
          executable = true;
          source = ./scripts/video-to-gif;
        };
      };
    };
}
