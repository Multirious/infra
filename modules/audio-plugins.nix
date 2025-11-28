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
      myPackages = top.config.flake.packages."${system}";
    in
    {
      options =
        let
          filesOption = lib.types.lazyAttrsOf (
            lib.types.submodule {
              options = {
                source = lib.mkOption {
                  type = lib.types.oneOf [
                    lib.types.package
                    lib.types.path
                  ];
                };
              };
            }
          );
        in
        {
          me.audio.vstFile = lib.mkOption { type = filesOption; };
          me.audio.vst3File = lib.mkOption { type = filesOption; };
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

        xdg.dataFile =
          (lib.mapAttrs' (path: value: {
            name = "vst/" + path;
            value = value;
          }) config.me.audio.vstFile)
          // (lib.mapAttrs' (path: value: {
            name = "vst3/" + path;
            value = value;
          }) config.me.audio.vst3File);
      };
    };
}
