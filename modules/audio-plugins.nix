top: {
  configurations.homeManager.peach.use = m: [ m.audioPlugins ];

  flake.modules.homeManager.audioPlugins =
    { pkgs, ... }:
    {
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
      # me.audio.vstFile."libsitala.so".source =
      #   let
      #     sitala = top.config.flake.packages."${pkgs.system}".sitala;
      #   in
      #   "${sitala}/lib/vst/libsitala.so";
    };
}
