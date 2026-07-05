top: {
  configurations.homeManager.peach.use = [ "audioPlugins" ];

  homeManager.audioPlugins.module =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      fileType =
        (pkgs.callPackage "${top.inputs.home-manager}/modules/lib/file-type.nix" {
          homeDirectory = config.home.homeDirectory;
        }).fileType;
      pluginTypes = [
        "vst"
        "vst3"
        "clap"
        "windowsVst"
        "windowsVst3"
      ];
    in
    {
      options = {
        me.audio =
          let
            genPluginTypes = lib.genAttrs' pluginTypes;
            homeOptions = genPluginTypes (name: {
              name = "${name}Home";
              value = lib.mkOption {
                type = lib.types.path;
                default = "${config.xdg.dataHome}/${name}";
              };
            });
            fileOptions = genPluginTypes (name: {
              name = "${name}File";
              value = lib.mkOption {
                type = fileType "me.audio.${name}File" "{var}`me.audio.${name}Home`" config.me.audio."${name}Home";
                default = { };
              };
            });
          in
          homeOptions // fileOptions;
      };

      config = {
        # home.file = lib.mkMerge (
        #   map (
        #     pluginType:
        #     lib.mapAttrs' (name: file: {
        #       name = "${config.me.audio."${pluginType}Home"}/${name}";
        #       value = file;
        #     }) config.me.audio."${pluginType}File"
        #   ) pluginTypes
        # );
        home.file =
          pluginTypes
          |> map (
            pluginType:
            config.me.audio."${pluginType}File"
            |> lib.mapAttrs' (
              name: file: {
                name = "${config.me.audio."${pluginType}Home"}/${name}";
                value = file;
              }
            )
          )
          |> lib.mkMerge;
      };
    };
}
