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
      inherit (pkgs.stdenv.hostPlatform) system;
      fileType =
        (pkgs.callPackage "${top.inputs.home-manager}/modules/lib/file-type.nix" {
          homeDirectory = config.home.homeDirectory;
        }).fileType;
      myPackages = top.config.flake.packages."${system}";
    in
    {
      options = {
        me.audio.vstHome = lib.mkOption {
          type = lib.types.path;
          default = "${config.xdg.dataHome}/vst";
        };
        me.audio.vst3Home = lib.mkOption {
          type = lib.types.path;
          default = "${config.xdg.dataHome}/vst3";
        };
        me.audio.clapHome = lib.mkOption {
          type = lib.types.path;
          default = "${config.xdg.dataHome}/clap";
        };
        me.audio.vstFile = lib.mkOption {
          type = fileType "me.audio.vstFile" "{var}`me.audio.vstHome`" config.me.audio.vstHome;
          default = { };
        };
        me.audio.vst3File = lib.mkOption {
          type = fileType "me.audio.vst3File" "{var}`me.audio.vst3Home`" config.me.audio.vst3Home;
          default = { };
        };
        me.audio.clapFile = lib.mkOption {
          type = fileType "me.audio.clapFile" "{var}`me.audio.clapHome`" config.me.audio.clapHome;
          default = { };
        };
      };

      config = {
        home.packages =
          let
            wine = pkgs.wineWowPackages.stableFull;
          in
          [
            (pkgs.yabridge.override { inherit wine; })
            (pkgs.yabridgectl.override { inherit wine; })
            wine
          ];

        me.audio.vstFile."Vital.so".source = "${pkgs.vital}/lib/vst/Vital.so";
        me.audio.vst3File."Vital.vst3".source = "${pkgs.vital}/lib/vst3/Vital.vst3";
        me.audio.vstFile."libsitala.so".source = "${myPackages.sitala}/lib/vst/libsitala.so";

        home.file = lib.mkMerge [
          (lib.mapAttrs' (
            name: file: lib.nameValuePair "${config.me.audio.vstHome}/${name}" file
          ) config.me.audio.vstFile)
          (lib.mapAttrs' (
            name: file: lib.nameValuePair "${config.me.audio.vst3Home}/${name}" file
          ) config.me.audio.vst3File)
        ];
      };
    };
}
