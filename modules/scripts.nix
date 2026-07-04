top: {
  configurations.homeManager.peach.use = [ "scripts" ];

  homeManager.scripts.module =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      options = {
        me.scripts =
          with lib.types;
          lib.mkOption {
            type = attrsOf (submodule {
              options = {
                text = lib.mkOption {
                  type = nullOr str;
                  default = null;
                };
                source = lib.mkOption { type = path; };
              };
            });
          };
      };
      config = {
        home.packages = lib.attrValues (
          lib.mapAttrs (
            scriptName: module:
            pkgs.writeTextFile {
              name = scriptName;
              text = if module.text != null then module.text else builtins.readFile module.source;
              executable = true;
              destination = "/bin/${scriptName}";
            }
          ) config.me.scripts
        );
      };

      # home.file = {
      #   "scripts/debug-derivative" = {
      #     executable = true;
      #     source = ./scripts/debug-derivative;
      #   };
      #   "scripts/clipboard-react-emote" = {
      #     executable = true;
      #     source = ./scripts/clipboard-react-emote;
      #   };
      #   "scripts/video-to-gif" = {
      #     executable = true;
      #     source = ./scripts/video-to-gif;
      #   };
      # };
    };
}
